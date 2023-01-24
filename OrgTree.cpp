// 2021111960 김희진

#include <iostream>
#include <string>

using namespace std;

const int defMaxSize = 10;

class treeNode {
public:

	string name;
	treeNode* subordinates; // 부하 직원들 배열
	int cursor; //부하 직원들 수


	treeNode() {
		name = "";
		cursor = -1;
	}
	treeNode(string n);
	void hire(string n);

};

treeNode::treeNode(string n) {
	name = n;
	subordinates = new treeNode[defMaxSize];
	cursor = -1;
}


void treeNode::hire(string sub) {
	cursor++;
	subordinates[cursor] = treeNode(sub);
}


treeNode* retriveNode(treeNode* root, string n, bool& flag) {

	if (root != NULL) {
		if (root->name == n) {
			flag = true;
			return root;
		}
		else {
			for (int i = 0; i <= root->cursor; i++) {

				treeNode* result = retriveNode(root->subordinates + i, n, flag);
				if (flag) {
					return result;
				}
			}
		}
	}
}

void print(treeNode* p, int level) {
	if (p->name != "") {
		for (int i = 0; i < level; i++) {
			cout << '+';
		}
		cout << p->name << endl;
		level++;
		for (int i = 0; i <= p->cursor; i++) {
			print(p->subordinates + i, level);
		}

	}

}

void fire(treeNode* f) {
	
	if (f->name != "") {
		if (f->subordinates->name != "") {
			f->name = f->subordinates[0].name;
			fire(f->subordinates);
		}
		else {
			f->name = "";
		}

		if (f->subordinates->name == "") {
			for (int i = 0; i < f->cursor; i++) {
				f->subordinates[i] = f->subordinates[i + 1];
			}
			if (f->cursor != -1) {
				f->cursor--;
			}

		}
	}
}

void main() {


	string str;
	string name1, name2;
	treeNode* root = NULL;
	
	cin >> name1; // 처음에 CEO 입력받기
	root = new treeNode(name1);
	cin.ignore();

	do {
		getline(cin, str);
		bool flag = false;

		if (str == "print") {
			cout << endl;
			print(root, 0);
			cout << "------------------------------------------" << endl;
		}
		else if (str.find("fire") != string::npos) {
			name1 = str.substr(str.find(" ")+1, str.length());
			treeNode* f= retriveNode(root, name1, flag);
			if (flag)
				fire(f);
			else
				cout << "Can't find node" << endl;

		}
		else if (str.find("hires") != string::npos) {
			name1 = str.substr(0, str.find(" "));
			name2 = str.substr(str.find("hires")+6, str.length());
			treeNode* f = retriveNode(root, name1, flag);
			if (flag)
				f->hire(name2);
			else
				cout << "Can't find node" << endl;

		}
		else{
			cout << "Inactive or invalid command" << endl;
		}

	} while (str != "Q" && str != "q");

}