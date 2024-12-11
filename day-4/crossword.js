const fs = require('fs');
let a=1;

const mas = "MAS".split("");
let cols = 0;
let rows = 0;
let count = 0;
let count2 = 0;

// I'm sorry, at least its fewer letters
let print = (x) => console.log(x);

function check1(xdir, ydir, i, j, lines){
    for(letter in mas) {
        let x = Number(i) + ((Number(letter) + 1) * (xdir));
        let y = Number(j) + ((Number(letter) + 1) * (ydir));
        if(x < 0 || x > cols || y < 0 || y > rows) {
            return;
        }
        if (lines[x][y] != mas[letter]) {
            return;
        }
    }
    count++;
}

function part1(i, j, lines) {
    for(let x =-1; x < 2; x++) { 
        for (let y=-1; y < 2; y++) {
            if (x == 0 && y == 0) {
                continue;
            }
            check1(x, y, i, j, lines);
        }
    }
}

let ms = ['M', 'S']
function part2(i, j, lines) {
    const b = 1;
    for(const a of [1, -1]) {
        let x = Number(i);
        let y = Number(j);
        if(x-1 < 0 || x+1 > cols || y-1 < 0 || y+1 > rows) {
            return;
        }
        let found=false;
        for (const k in ms) {
            if(!(lines[x+a][y+b] == ms[k] && lines[x-a][y-b] == ms[1-k])) {
                continue;
            }
            found=true;
        }
        if (!found) {
            return;
        }
    }
    count2++
}

function processLines(lines) {
    for(const i in lines) {
        for(const j in lines[i]) {
            if(lines[i][j] == 'X') {
                part1(i, j, lines);
            }
            else if(lines[i][j] == 'A') {
                part2(i, j, lines)
            }
        }
    }
}

// Open file demo.txt in read mode
fs.readFile('input.txt', 'utf8', (err, content) => {
    let lines = content.split("\n");
    cols = lines[0].length;
    rows = lines.length;
    for (const i in lines) {
        const line = lines[i].split("");
        if (line != []) {
            lines[i] = line;
        }
    }
    processLines(lines);

    print("part 1:");
    print(count);
    print("part 2:");
    print(count2);
});
