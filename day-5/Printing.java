import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;
import java.util.HashMap;
import java.util.ArrayList;
import java.util.Collections;

class Printing {
  private static HashMap<Integer, ArrayList<Integer>> dict = 
    new HashMap<Integer, ArrayList<Integer>>();
  private static int sum = 0;
  private static int sum2 = 0;

  public static boolean sort(ArrayList<Integer> pref) {
    for(int i=0; i<pref.size(); i++) {
      ArrayList<Integer> suffix = dict.get(pref.get(i));
      if (suffix == null) continue; 
      for(int j=0; j<i; j++) {
        if(suffix.contains(pref.get(j))) {
          Collections.swap(pref, i, j);
          //System.out.println(pref.get(i) + " " + pref.get(j)); 
          return false;
        }
      }
    }
    return true;
  }

  public static void main(String[] args) {
    String delim = "[|]";
    int runtime = 0;
    try {
      File f = new File("input.txt");
      Scanner scanner = new Scanner(f);
      while (scanner.hasNextLine()) {

        String line = scanner.nextLine();
        String[] arr = line.split(delim);
        if(arr.length == 1) { 
          delim = "[,]";
          //System.out.println(dict);
          continue;
        }

        if (delim == "[|]") {
          runtime += 1;

          int key = Integer.parseInt(arr[0]);
          int value = Integer.parseInt(arr[1]);

          if (dict.get(key) == null) {
            // FOR SOME REASON THIS DIDN"T WORK??? I DON"T KNOW JAVA????
            //dict.put(key, new ArrayList<Integer>(value));
            dict.put(key, new ArrayList<Integer>());
            dict.get(key).add(value);
          }
          else {
            if(!dict.get(key).add(value)) System.out.println("repeat!");
          }

        } else {
          ArrayList<Integer> pref = new ArrayList<Integer>();
          boolean valid = true;

          for (String s : arr){
            int val = Integer.parseInt(s);
            pref.add(val); 
            if (dict.get(val) == null) continue;

            for(int x : pref) {
              if (dict.get(val).contains(x)) {
                valid = false;
              }
            }
          }
          if (valid == true) {
            sum += pref.get((int)(pref.size()/2));
          } else {
            boolean sorted = false;

            //System.out.println(pref);
            while (!sorted) {
              sorted = sort(pref);
            }
            //System.out.println(pref);
            //System.out.println(pref.get((int)(pref.size()/2)));

            //System.out.println();

            //for(int x=0; x<pref.size(); x++) {
            //  for(int y=0; y<x; y++) {
            //    if (dict.get(pref.get(x)).contains(pref.get(y))) {
            //      System.out.println("test failed");
            //    }
            //  }
            //}
            sum2 += pref.get((int)(pref.size()/2));
          }
        }
        
      }
      scanner.close();
    } catch (FileNotFoundException e){
      System.out.println(e);
      e.printStackTrace();
    }

    System.out.println(sum);
    System.out.println(sum2);
    
    /*
    int siz = 0;
    for (Integer x : dict.keySet()) {
      siz += dict.get(x).size();
    }
    System.out.println(siz);

    System.out.println(runtime);
    */

  }
}
