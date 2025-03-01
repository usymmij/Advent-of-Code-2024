use std::fs;

fn main() {
    let input = fs::read_to_string("input.txt").expect("couldn't read file");

    let equations = input.lines();
    let mut total: i128 = 0;
    for eq in equations {
        let mut eq_parts = eq.split(":");
        let targ: Option<&str> = eq_parts.next();

        let components_extract: Option<&str> = eq_parts.next();
        let components = components_extract.as_ref().unwrap().split(" ");

        let target = targ.as_ref().unwrap().parse::<i128>().unwrap();
        //println!("\ntarget: {target}");

        let mut parse_vec: Vec<i128> = Vec::new();

        //println!("terms:");
        for term in components.into_iter() {
            match term.parse::<i128>() {
                Ok(n) => {
                    //println!("{n}");
                    if *(&parse_vec.len()) == 0usize {
                        parse_vec.push(n);
                    } else {
                        // im so confused
                        let mut temp_vec: Vec<i128> = Vec::new();
                        for element in &parse_vec {
                            temp_vec.push(n + element);
                            temp_vec.push(n * element);

                            // this following line is for part 2
                            let mut i = 1;
                            let mut _n: i128 = n;
                            while _n > 0 {
                                _n /= 10;
                                i *= 10;
                            }
                            //println!("n:{n}, i:{i}, element:{element}");
                            temp_vec.push(n + (i * element));
                        }
                        parse_vec = temp_vec;
                    }
                }
                Err(_) => continue,
            }
        }

        //for element in &parse_vec {
        //    println!("{element}");
        //}

        if parse_vec.contains(&target) {
            total += target;
        }
    }
    println!("\ntotal: {total}");
}
