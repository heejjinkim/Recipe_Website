#include <iostream>
#include <list>

using namespace std;

const int MaxSize = 20;

class FaceBook;

class Person {
private:
	Person() {};
	Person(string n);

	string name;
	list<Person> friendlist;

	string getName(); 
	void setFriend(Person f);
	void showFriends();
	bool isFriend(string f);
	void removeFriend(string f);

	friend class FaceBook;

};

class FaceBook {
public:
	FaceBook(int maxNumber = MaxSize);
	~FaceBook();

	bool retriveItem(string n);
	int getIndex(string n);
	void createItem(string n);
	void addFriend(string p, string f); 
	void getFriends(string n);
	void removeFriend(string p, string f); 
	bool isFriend(string p, string f); 

private:
	Person* dataItems;
	int maxSize;
	int cursor;
};

Person::Person(string n) {
	name = n;
}

string Person::getName() {
	return name;
}

void Person::setFriend(Person f) {
	friendlist.push_back(f);
}

void Person::showFriends() {
	list<Person>::iterator it;

	for (it = friendlist.begin(); it != friendlist.end(); it++) {
		cout << it->getName() << " ";
	}
}

bool Person::isFriend(string f) {
	list<Person>::iterator it;

	for (it = friendlist.begin(); it != friendlist.end(); it++) {
		if (it->getName() == f) {
			return true;
		}
	}
	return false;
}

void Person::removeFriend(string f) {
	list<Person>::iterator it;

	for (it = friendlist.begin(); it != friendlist.end(); it++) {
		if (it->getName() == f) {
			friendlist.erase(it);
			return;
		}
	}
}

FaceBook::FaceBook(int maxNumber) {
	maxSize = maxNumber;
	cursor = -1;
	dataItems = new Person[maxSize];
}

FaceBook::~FaceBook()
{
	delete[] dataItems;
}


bool FaceBook::retriveItem(string n) {
	for (int i = 0; i <= cursor; i++) {
		if (dataItems[i].name == n) {
			return true;
		}
	}
	return false;
}

int FaceBook::getIndex(string n) {
	for (int i = 0; i <= cursor; i++) {
		if (dataItems[i].name == n) {
			return i;
		}
	}
}

// P
void FaceBook::createItem(string n) {

	dataItems[++cursor] = Person(n);

}

// F
void FaceBook::addFriend(string p, string f) {
	if (retriveItem(p) && retriveItem(f)) {
		int index = getIndex(p);
		int f_index = getIndex(f);
		dataItems[index].setFriend(dataItems[f_index]);

		index = getIndex(f);
		f_index = getIndex(p);
		dataItems[index].setFriend(dataItems[f_index]);
	}
	else {
		cout << "Person doesn't exist" << endl;
		return;
	}

}

// L
void FaceBook::getFriends(string n) {
	if (retriveItem(n)) {
		int index = getIndex(n);
		dataItems[index].showFriends();
		cout << endl;
	}
}

// U
void FaceBook::removeFriend(string p, string f) {
	if (retriveItem(p)) {
		int index = getIndex(p);
		dataItems[index].removeFriend(f);
	}
}

// Q ���
bool FaceBook::isFriend(string p, string f) {
	if (retriveItem(p)) {
		int index = getIndex(p);
		int f_index = getIndex(f);
		if (dataItems[index].isFriend(f)) {
			return true;
		}
		else {
			return false;
		}
	}
}

void print_help()
{
	cout << endl << "Commands:" << endl;
	cout << "  P <name>         : Create a person record of the specified name" << endl;
	cout << "  F <name1><name2> : Record that the two specified people are friends." << endl;
	cout << "  U <name1><name2> : Record that the two specified people are no longer friends." << endl;
	cout << "  L <name>         : Print out the friends of the specified person." << endl;
	cout << "  Q <name1><name2> : Check whether the two people are friends" << endl;
	cout << "  X                : terminate the program." << endl;
	cout << endl;
}

int main() {

	FaceBook testBook;
	char cmd;
	string name1;
	string name2;

	print_help();

	do {
		cout << endl << "Command: ";
		cin >> cmd;
		switch (cmd)
		{
		case 'P': case 'p':
			cin >> name1;
			testBook.createItem(name1);
			break;

		case 'F': case 'f':
			cin >> name1 >> name2;
			testBook.addFriend(name1, name2);
			break;

		case 'U': case 'u':
			cin >> name1 >> name2;
			testBook.removeFriend(name1, name2);
			testBook.removeFriend(name2, name1);
			break;

		case 'L': case 'l':
			cin >> name1;
			testBook.getFriends(name1);
			break;

		case 'Q': case 'q':
			cin >> name1 >> name2;
			if (testBook.isFriend(name1, name2))
				cout << "YES" << endl;
			else
				cout << "NO" << endl;
			break;

		case 'X': case 'x':
			break;

		default:
			cout << "Inactive or invalid command" << endl;
		}

	} while (cmd != 'x' && cmd != 'X');
}