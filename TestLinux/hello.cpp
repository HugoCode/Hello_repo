#include <stdio.h>
#include <fstream>
#include <iostream>
using namespace std;
void hello(const char *name) 
{ 
	string strPath = "test.log";
	ofstream testLog;
	testLog.open(strPath.c_str(),ios::app|ios::out);
	testLog<<"dsjdfjkadkf\n����Ĭ�ϱ��뷽ʽ���ٺ�\n"<<name;
	testLog.flush();
	testLog.close();
        printf("Hello %s!\n", name); 
}