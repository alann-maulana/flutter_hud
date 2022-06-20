Iterable<int> primesMap() {
  Iterable<int> oddPrimes() sync* {
    yield (3);
    yield (5); // need at least 2 for initialization
    final Map<int, int> bpmap = {9: 6};
    final Iterator<int> bps = oddPrimes().iterator;
    bps.moveNext();
    bps.moveNext(); // skip past 3 to 5
    int bp = bps.current;
    int n = bp;
    int q = bp * bp;
    while (true) {
      n += 2;
      while (n >= q || bpmap.containsKey(n)) {
        if (n >= q) {
          final int inc = bp << 1;
          bpmap[bp * bp + inc] = inc;
          bps.moveNext();
          bp = bps.current;
          q = bp * bp;
        } else {
          final int? inc = bpmap.remove(n);
          if (inc != null) {
            int next = n + inc;
            while (bpmap.containsKey(next)) {
              next += inc;
            }
            bpmap[next] = inc;
          }
        }
        n += 2;
      }
      yield (n);
    }
  }

  return [2].followedBy(oddPrimes());
}

Future<String> getPrimes({int delayedSeconds = 2}) async {
  await Future.delayed(Duration(seconds: delayedSeconds));
  return primesMap().take(10).join(', ');
}
