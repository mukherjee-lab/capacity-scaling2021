omega = 0.1;
theta = 15 * 850 / (1000 * 60 * 60);
beta = 4 * 60 * 60 * theta;

for err = [1 2 4]
    for conf = [1 3 5]
        cr_ftp = zeros(13, 1);
        cr_bcs = zeros(13, 1);
        
        i = 1;
        for f = [0.01 0.1 1 10 100]
            [cr_ftp(i), cr_bcs(i)] = run(omega * f, theta, beta, "peak", conf, err);
            disp("The competitive ratio of FTP is " + cr_ftp(i));
            disp("The competitive ratio of BCS is " + cr_bcs(i));
            i = i + 1;
        end

        for f = [0.01 0.1 10 100]
            [cr_ftp(i), cr_bcs(i)] = run(omega, theta * f, beta, "peak", conf, err);
            disp("The competitive ratio of FTP is " + cr_ftp(i));
            disp("The competitive ratio of BCS is " + cr_bcs(i));
            i = i + 1;
        end

        for f = [0.01 0.1 10 100]
            [cr_ftp(i), cr_bcs(i)] = run(omega, theta, beta * f, "peak", conf, err);
            disp("The competitive ratio of FTP is " + cr_ftp(i));
            disp("The competitive ratio of BCS is " + cr_bcs(i));
            i = i + 1;
        end

        save("crs_peak_conf_" + conf + "_err" + err + ".mat", "cr_ftp", "cr_bcs");
    end
end