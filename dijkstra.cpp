#include <fstream>
#include <string>
#include <vector>
#include <queue>
#include <iostream>

using namespace std;

#define MAX 600 //최대 정점의 개수
#define INF 1e9

vector<pair<int, float>> adj[MAX]; //인접리스트. 이중배열. 인덱스가 시작점의 인덱스. <도착점 인덱스, 가중치>
vector<string> nodeInfo; //인덱스에 따른 노드의 이름 저장
vector<int> before; //이전에 방문한 노드의 인덱스가 저장


vector<float> dijkstra(int startIdx, int V) {
	vector<float> dist(V, INF);    // 전부 INF로 초기화. 크기는 정점의 수 V. 시작점에 대한 모든 정점의 최단 거리 저장 
	priority_queue<pair<float, int> > pq; //<목표 정점까지의 dist 값, 정점의 index값>

	dist[startIdx] = 0;
	pq.push(make_pair(0, startIdx));    // 시작 정점 방문 
	before[startIdx] = startIdx;

	while (!pq.empty()) {
		float cost = -pq.top().first;    // 방문한 정점의 dist 값 
		int cur = pq.top().second;    // 현재 방문한 정점의 인덱스
		pq.pop();

		for (int i = 0; i < adj[cur].size(); i++) {    // 현재 방문한 정점의 주변 정점 모두 조사. size는 cur정점과 이어진 가중치 수
			int next = adj[cur][i].first;    // 조사할 다음 정점. 시작점이 cur이고 i(가중치 인덱스)의 first(정점이름)
			float nCost = cost + adj[cur][i].second;    // 현재 방문한 정점을 거쳐서 다음 정점을 갈때의 비용 
			if (nCost < dist[next]) {     // 기존 비용보다 현재 방문한 정점을 거친 비용이 더 싸다면 
				dist[next] = nCost;    // 갱신 
				before[next] = cur;    //next로 가는 최단경로는 직전에 cur을 거침.
				pq.push(make_pair(-nCost, next));    // pq에 저장 
			}
		}
	}
	return dist;
}

template<class iter, class T>
iter myfind(iter first, iter last, const T& value) {
	for (; first != last; ++first) {
		if (*first == value)
			return first;
	}
	return last;
}

int main() {
	fstream fs;
	string from, to;
	float cost;
	int fromIndex, toIndex;
	int index = 0; 

	fs.open("최종데이터.csv", ios::in);
	while (!fs.eof()) {

		//, 단위로 읽어서 buffer에 저장 (시작 노드 이름, 도착 노드 이름, 거리) 반복
		getline(fs, from, ','); //시작 노드 이름
		getline(fs, to, ','); //도착 노드 이름
		fs >> cost; //둘 사이의 가중치

		auto it = myfind(nodeInfo.begin(), nodeInfo.end(), from); //nodeInfo에서 from 노드를 찾음
		if (it == nodeInfo.end()) { //찾지못함. 새로운 노드
			fromIndex = index;
			nodeInfo.push_back(from);
			index++;
		}
		else { //찾았음. 이미 있는 인덱스값을 찾음
			fromIndex = it - nodeInfo.begin();
		}

		it = myfind(nodeInfo.begin(), nodeInfo.end(), to); //nodeInfo에서 to 노드를 찾음
		if (it == nodeInfo.end()) { //찾지못함. 새로운 버텍스
			toIndex = index;
			nodeInfo.push_back(to);
			index++;
		}
		else { //찾았음. 이미 있는 인덱스값을 찾아 가중치 추가
			toIndex = it - nodeInfo.begin();
		}
		adj[fromIndex].push_back(make_pair(toIndex, cost)); //양방향 그래프
		adj[toIndex].push_back(make_pair(fromIndex, cost));	

		fs.ignore(); //'\n' 무시
	}

	before.assign(index, -1); //before의 크기 노드의 수만큼 지정, -1로 초기화

	//사용자에게 출발, 도착 지점 입력받기
	string start;
	string goal;

	cout << "출발 강의실을 입력하세요 (ex 원흥관 314): "; //신공학관 6119
	getline(cin, start);
	auto it = myfind(nodeInfo.begin(), nodeInfo.end(), start);
	if (it == nodeInfo.end()) {
		cout << "데이터에 존재하지 않는 강의실입니다." << endl;
		return 0;
	}
	fromIndex = it - nodeInfo.begin(); //시작 노드 인덱스

	vector<float> dist = dijkstra(fromIndex, index); //시작점에서 모든 정점으로의 최단경로 계산

	cout << "도착 강의실을 입력하세요 (ex 신공학관 6119): ";
	getline(cin, goal);
	it = myfind(nodeInfo.begin(), nodeInfo.end(), goal);
	if (it == nodeInfo.end()) {
		cout << "데이터에 존재하지 않는 강의실입니다." << endl;
		return 0;
	}
	toIndex = it - nodeInfo.begin(); // 도착 노드 인덱스

	vector<string> route;
	route.push_back(nodeInfo[toIndex]);
	while (toIndex != fromIndex) { //목표지점을 시작으로 경로 역추적하여 route에 저장
		string name = nodeInfo[before[toIndex]];
		route.push_back(name);
		toIndex = before[toIndex];
	}
	
	//route를 거꾸로 출력하여 최단 경로 출력
	cout << "\n***START!!***" << endl << route[route.size() - 1] << endl; //시작노드 출력
	for (int i = route.size()-2; i >= 0; i--) {
		cout << " ->" << route[i]  << endl;
	}
	cout <<  " ***GOAL!!***" << endl;
}