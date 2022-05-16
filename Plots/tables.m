omega = 0.1;
theta = 15 * 850 / (1000 * 60 * 60);
beta = 4 * 60 * 60 * theta;
delta = 5;

type = "shark";
conf = 5;
err = 4;

fname = "data_" + type + "_w" + omega * delta + "_t" + theta * delta + "_b" + beta + "_c" + conf + "_e" + err + ".mat";
load(fname);%, "cr_ftp", "cr_bcs", "optcost");

disp(cr_ftp);
disp(cr_bcs);