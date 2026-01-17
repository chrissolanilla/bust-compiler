import std.file: write, readText, FileException;
import std.stdio;
import std.string: stripRight;
import std.array :split, join;

immutable string[string] opMap = [
	"move": "mov",
	"jump": "jmp",
	"jumpNotEqual": "jne",
	"jumpEqual": "je",
	"compare": "cmp",
	"add": "add",
	"defineByte": "db",
	"defineWord": "dw",
	"defineDWord": "dd",
	"defineQWord": "dq",
	"xor": "xor",
	"test": "test",
	"syscall": "syscall",
	"loadEffectiveAddress": "lea"
];


string translateWord(string word){
	if(auto p = word in opMap){
		return *p;
	}
	return word;
}

//this is fucking divine intellect
void main(string[] args) {
	if (args.length < 2) {
        writeln("usage: goon <input.bust>  ---> bustOut.asm");
        return;
    }

	try {
		string fileContent = readText(args[1]);
		string outputPath = (args.length >= 3) ? args[2] : "bustOut.asm";
		//no args make it split by whitespace
		//doing this actually kills the new lines
		// string[] words = strip(fileContent).split();

		string[] lines = fileContent.split("\n");
		string[] outLines;
		outLines.reserve(lines.length);

		//i is index, w is the word it self.
		foreach(line; lines) {
			if(line.length == 0){
				outLines ~= "";
				continue;
			}
			string[] words = line.split();
			foreach(ref w; words){
				w = translateWord(w);
			}

			outLines ~= words.join(" ");
		}

		write(outputPath, outLines.join("\n"));
		// writeln(fileContent);
	} catch(FileException e) {
		writeln("ep rda");
		writeln(e.message);
	}

}
