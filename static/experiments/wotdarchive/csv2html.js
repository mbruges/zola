export function csv2html(csvFile) {
    console.log("all ok")
    var htmlFile = `<tr>
    <th>`
    var breakpoint = ""

    //First, we separate the header row from the main body.
    for (let index = 0; index < csvFile.length; index++) {
        breakpoint = csvFile.charAt(index)
        if (breakpoint == "\n") {
            breakpoint = index;
            break;
       }
    }
    breakpoint = parseInt(breakpoint)
    const header = csvFile.slice(0,breakpoint)
    const body = csvFile.slice(breakpoint+1,((csvFile.length)+1))

    //Now, we define the header
    for (let index = 0; index < header.length; index++) {
        let charToChange = "" + header.charAt(index)
        if (charToChange == "\n") {
            console.log("linebreak detected");
            charToChange = "</tr>\n<tr>\n<td>";
            htmlFile += charToChange;
        } else if (charToChange == ",") {
            charToChange = "</th>\n<th>"
            htmlFile += charToChange
        }
        else {
            charToChange = `${charToChange}`;
            htmlFile += charToChange
        }
    }
    let endpoint = (htmlFile.length - 4)
    htmlFile = htmlFile.slice(0, endpoint);
    htmlFile += `</tr>\n<tr>\n<td>`

    //Now, the main body:
for (let index = 0; index < body.length; index++) {
    let charToChange = "" + body.charAt(index)
    if (charToChange == "\n") {
        charToChange = "</tr>\n<tr>\n<td>"
        htmlFile += charToChange
    } 
    else if ((charToChange == ",")) {
        charToChange = "</td>\n<td>"
        htmlFile += charToChange
    }
    else if (charToChange == `\n`){
        console.log("linebreak detected");
       endpoint = (htmlFile.length - 4)
        htmlFile.slice(0, endpoint);
        charToChange = "</tr>\n<tr>"
        htmlFile += charToChange
    }
     else {
        charToChange = `${charToChange}`;
        htmlFile += charToChange }
    }

//now to trim the last bit and replace with </tr>
endpoint = (htmlFile.length - 4)
htmlFile = htmlFile.slice(0,endpoint);
   htmlFile += `</tr>`
    let tidiedHTML = htmlFile.replace(`<td></td></tr>`, "</tr>")
    return tidiedHTML;
}
