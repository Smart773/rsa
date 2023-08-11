class Util {
  // static Check if the string is prime or not
  static bool isPrime(String value) {
    int n = int.parse(value);
    if (n <= 1) {
      return false;
    }
    for (int i = 2; i < n; i++) {
      if (n % i == 0) return false;
    }
    return true;
  }

  // Gcd of two numbers
  static int gcd(int a, int b) {
    if (a == 0) return b;
    return gcd(b % a, a);
  }
  static int modInverse(int a, int m) {
    a = a % m;
    for (int x = 1; x < m; x++) {
      if ((a * x) % m == 1) return x;
    }
    return 1;
  }

  // modPow(m, e, n)
  static int modPow(int m, int e, int n) {
    int res = 1;
    m = m % n;
    while (e > 0) {
      if (e % 2 == 1) res = (res * m) % n;
      e = e ~/ 2;
      m = (m * m) % n;
    }
    return res;
  }

  
}
