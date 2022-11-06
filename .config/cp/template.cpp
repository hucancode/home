#include <bits/stdc++.h>
using namespace std;
#pragma GCC optimize("Ofast,no-stack-protector,unroll-loops,fast-math")
#pragma GCC target("sse,sse2,sse3,ssse3,sse4.1,sse4.2,avx,avx2,popcnt,tune=native")
#define FOR(i,a,b) for (int i = a; i <= b; i++)
#define RFOR(i,a,b) for (int i = a; i >= b; i--)
#ifdef LOCAL
#define LOG 
#else
#define LOG if(false)
#endif
typedef long long ll;
typedef vector<int> vi;
typedef pair<int,int> pi;
typedef vector<vi> vvi;
typedef vector<pi> vpi;
typedef vector<ll> vl;
typedef vector<vl> vvl;
typedef pair<long, int> pli;

void solve() {
  int n;
  cin>>n;
  int ret = 0;
  cout<<ret<<'\n';
}

int main() {
  ios_base::sync_with_stdio(false);
  cin.tie(NULL);
#ifdef LOCAL
  auto starttime = chrono::high_resolution_clock::now();
#endif
  int t;
  cin>>t;
  while(t--) {
    solve();
  }
#ifdef LOCAL
  auto endtime = chrono::high_resolution_clock::now();
  auto duration = chrono::duration_cast<chrono::milliseconds>(endtime - starttime).count(); 
  cout << "\n=====" << "\nUsed: " << duration << " ms\n";
#endif
  return 0;
}
