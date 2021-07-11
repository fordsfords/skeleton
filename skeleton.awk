# skeleton.awk - skeletal AWK program with some functions that I sometimes use.
#
# This code and its documentation is Copyright 2002-2021 Steven Ford
# and licensed "public domain" style under Creative Commons "CC0":
#   http://creativecommons.org/publicdomain/zero/1.0/
# To the extent possible under law, the contributors to this project have
# waived all copyright and related or neighboring rights to this work.
# In other words, you can use this code for any purpose without any
# restrictions.  This work is published from: United States.  The project home
# is https://github.com/fordsfords/skeleton

function error(s) {
    printf("skeleton: %s\n", s)
    status = 1
    exit(status)
}


#function tolower(s,    i,res,ofs) {
#    res = ""
#    for (i=1; i<=length(s); ++i) {
#        ofs = index(uc, substr(s, i, 1))
#        if (ofs == 0)
#            res = res substr(s, i, 1)
#        else
#            res = res substr(lc, ofs, 1)
#    }
# 
#    return res
#}  # tolower
 
 
#function toupper(s,    i,res,ofs) {
#    res = ""
#    for (i=1; i<=length(s); ++i) {
#        ofs = index(lc, substr(s, i, 1))
#        if (ofs == 0)
#            res = res substr(s, i, 1)
#        else
#            res = res substr(uc, ofs, 1)
#    }
# 
#    return res
#}  # toupper


function roman(i,  tens,ones) {
    ones = i % 10
    tens = (i - ones)
    return roman_num[tens] roman_num[ones]
}  # roman


function ualpha(i,  lsc,msc) {
    lsc = (i - 1) % 26      # gives 0-25 for 1-26, 27-52, ...
    msc = ((i - 1) - lsc) / 26 # gives 0 for 1-26, 1 for 27-52, ...
    if (msc == 0)
        return substr(uc, lsc + 1, 1)
    else
        return substr(uc, msc, 1) substr(uc, lsc + 1, 1)
}  # ualpha
 

function lalpha(i,  lsc,msc) {
    lsc = (i - 1) % 26      # gives 0-25 for 1-26, 27-52, ...
    msc = ((i - 1) - lsc) / 26 # gives 0 for 1-26, 1 for 27-52, ...
    if (msc == 0)
        return substr(lc, lsc + 1, 1)
    else
        return substr(lc, msc, 1) substr(lc, lsc + 1, 1)
}  # lalpha


#
# Functions to convert between decimal and hex
#

# do byte_swap for Intel format
function hexr(h,  l)
{
    l = length(h)
    if (l <= 2)          # 1 byte (or 1 nibble)
        return(h)
    else if (l == 4)     # 2 bytes
        return(substr(h, 3, 2) substr(h, 1, 2))
    else if (l == 8)     # 4 bytes
        return(substr(h, 7, 2) substr(h, 5, 2) substr(h, 3, 2) substr(h, 1, 2))
    else
        print "hexr: bad length for " h
}  # hexr


# convert hex to decimal
function hex2dec(h,  d,i)
{
    d = 0
    for (i=1; i<=length(h); ++i) {
        d = 16*d + h2d[substr(h, i, 1)]
    }
    return d
}  # hex2dec


# convert hex to decimal (use Intel byte-swapped format)
function hexr2dec(h)
{
    return(hex2dec(hexr(h)))
}  # hexr2dec


# convert decimal to hex (w=width)
function dec2hex(d,w)
{
    return substr(sprintf("%016x", d), 17-w)
}  # dec2hex


# convert decimal to hex (w=width) (use Intel byte-swapped format)
function dec2hexr(d,w)     # use Intel byte-swapped format
{
    return hexr(substr(sprintf("%016x", d), 17-w))
}  # dec2hexr


BEGIN {
    h2d["0"]=0;h2d["1"]=1;h2d["2"]=2;h2d["3"]=3;h2d["4"]=4
    h2d["5"]=5;h2d["6"]=6;h2d["7"]=7;h2d["8"]=8;h2d["9"]=9
    h2d["a"]=10;h2d["b"]=11;h2d["c"]=12;h2d["d"]=13;h2d["e"]=14;h2d["f"]=15
    h2d["A"]=10;h2d["B"]=11;h2d["C"]=12;h2d["D"]=13;h2d["E"]=14;h2d["F"]=15
    uc = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    lc = "abcdefghijklmnopqrstuvwxyz"
    spaces = "                                                                               "
    roman_num[0] = "";    roman_num[1] = "I";    roman_num[2] = "II"
    roman_num[3] = "III"; roman_num[4] = "IV";   roman_num[5] = "V"
    roman_num[6] = "VI";  roman_num[7] = "VII";  roman_num[8] = "VIII"
    roman_num[9] = "IX";  roman_num[10]= "X";    roman_num[20]= "XX"
    roman_num[30]= "XXX"; roman_num[40]= "XL";   roman_num[50]= "L"
    roman_num[60]= "LX";  roman_num[70]= "LXX";  roman_num[80]= "LXXX"
    roman_num[90]= "XC"

    status = 0
}  # BEGIN


# MAIN
{
}


END {
    if (status == 0) {
    }

    exit(status)
}
