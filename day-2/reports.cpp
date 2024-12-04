#include <fstream>
#include <iostream>
#include <string>
#include <vector>

bool check(std::vector<int> diff, int inc) {
  for (int i = 0; i < diff.size(); i++) {
    int x = diff[i] * inc;
    if (!(x > 0 && x < 4)) {
      return false;
    }
  }
  return true;
}

int main() {
  std::ifstream infile("./input.txt");
  std::string linebuffer;
  int safeCount = 0;
  int tolerCount = 0;
  std::vector<int> diffs[1024];
  int line = 0;

  if (infile.is_open()) {
    while (getline(infile, linebuffer)) {
      std::string word;
      int linelen = 0;
      for (int i = 0; i < linebuffer.length(); i++) {
        if (linebuffer.at(i) == ' ') {
          linelen += 1;
        }
      }
      // diff arr is 1 shorter than number of numbers, since we only track diffs

      int arr[linelen];
      std::vector<int> diff;
      int i = 0;
      int prev = 0;
      while (linebuffer.compare("") != 0) {
        // contains word until next space, (or end of line otherwise)
        int end = linebuffer.find(" ");
        end = end + (end < 0 ? 0 : 1);
        word = linebuffer.substr(0, end);

        if (prev == 0) {
          prev = std::stoi(word);
        } else {
          diff.push_back(std::stoi(word) - prev);
          prev = std::stoi(word);
        }

        linebuffer = linebuffer.substr(word.length());
      }
      diffs[line++] = diff;
    }
    infile.close();

    for (int i = 0; i < line; i++) {
      std::vector<int> diff = diffs[i];

      if (!(check(diff, 1) || check(diff, -1))) {
        std::vector<int> fwd(diff);
        std::vector<int> bwd(diff);
        fwd.pop_back();
        bwd.erase(bwd.begin() + 0);
        if (check(fwd, 1) || check(fwd, -1) || check(bwd, 1) ||
            check(bwd, -1)) {
          tolerCount++;
          continue;
        }
        for (int j = 0; j < diff.size() - 1; j++) {
          int rep = diff[j] + diff[j + 1];
          std::vector<int> rem(diff);
          rem.erase(rem.begin() + j);
          rem[j] = rep;

          if (!(check(rem, 1) || check(rem, -1))) {
            continue;
          }
          tolerCount++;
          break;
        }
        continue;
      }
      safeCount++;
    }

    std::cout << "safe reports: ";
    std::cout << safeCount << std::endl;

    std::cout << "tolerant reports: ";
    std::cout << safeCount + tolerCount << std::endl;

    return 0;
  }
}
