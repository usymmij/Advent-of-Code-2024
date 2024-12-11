const fs = require('fs');
let a=1;

const mas = "MAS".split("");
let cols = 0;
let rows = 0;
let count = 0

// I'm sorry, at least its fewer letters
let print = (x) => console.log(x);

function checkDir(xdir, ydir, i, j, lines){
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

function processX(i, j, lines) {
    for(let x =-1; x < 2; x++) { 
        for (let y=-1; y < 2; y++) {
            if (x == 0 && y == 0) {
                continue
            }
            checkDir(x, y, i, j, lines);
        }
    }
}

function processLines(lines) {
    for(const i in lines) {
        for(const j in lines[i]) {
            if(lines[i][j] == 'X') {
                processX(i, j, lines);
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
    print(count);
});
