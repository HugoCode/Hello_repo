#include <stdio.h>
#include <fstream>
#include <iostream>
using namespace std;
void hello(const char *name) 
{ 
	string strPath = "test.log";
	ofstream testLog;
	testLog.open(strPath.c_str(),ios::app|ios::out);
	testLog<<"dsjdfjkadkf\n²âÊÔÄ¬ÈÏ±àÂë·½Ê½£¬ºÙºÙ\n"<<name;
	testLog.flush();
	testLog.close();
        printf("Hello %s!\n", name); 
}