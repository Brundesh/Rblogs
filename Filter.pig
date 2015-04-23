a = load 'part-m-00000' using PigStorage();
sony = filter a by($1 matches '.*Sony.*');
kodak = filter a by($1 matches '.*kodak.*');
store sony into 'sonyout';
store sony into 'kodakout';
