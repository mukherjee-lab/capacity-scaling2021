startDate = datetime(2016, 4, 23, 23, 54, 3);

counts = zeros(24 * 60 * 60 + 1 * 60, 1);
curDate = startDate;

for i = 1:24
    disp(datestr(curDate, "yyyymmdd_HHMMSS"));
    fid = fopen(datestr(curDate, "yyyymmdd_HHMMSS") + ".pcap_req.csv");
    str = textscan(fid, "%s", "Delimiter", "\n");
    fclose(fid);
    
    str = str{1};
    str(count(str, ",") ~= 7) = [];
    data = split(str, ",");
    data = data(:, 7);
    
    timestamps = datetime(data, "InputFormat", "dd/MM/yy HH:mm:ss");
    timestamps = timestamps + 5.5 * hours;
    timestamps = seconds(time(between(startDate, timestamps))) + 1;
    counts = counts + accumarray(timestamps, 1, [size(counts, 1) 1]);
    
    delete(datestr(curDate, "yyyymmdd_HHMMSS") + ".pcap");
    delete(datestr(curDate, "yyyymmdd_HHMMSS") + ".pcap_label.csv");
    delete(datestr(curDate, "yyyymmdd_HHMMSS") + ".pcap_log.csv");
    delete(datestr(curDate, "yyyymmdd_HHMMSS") + ".pcap_req.csv");
    delete(datestr(curDate, "yyyymmdd_HHMMSS") + ".pcap_res.csv");
    
    curDate = curDate + 1 * hours + 1 * seconds;
end

save("counts_" + datestr(startDate, "yyyymmdd_HHMMSS") + ".mat", "counts");