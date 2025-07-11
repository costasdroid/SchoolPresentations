const fs = require("fs");
const path = require("path");

// Helper to escape GIFT special characters in [plain] questions
function escapeGift(text) {
  // Double backslashes before LaTeX commands (e.g., \ne, \le, \ge, etc.)
  text = text.replace(/\\([a-zA-Z])/g, "\\\\$1");
  return text
    .replace(/([~=#{}:])/g, "\\$1") // escape ~ = # { } :
    .replace(/\n/g, " "); // replace newlines with space
}

function parseQuestions(input) {
  // Split by double newlines (each question is separated by a blank line)
  return input
    .split(/\n\s*\n/)
    .map((q) => q.trim())
    .filter(Boolean);
}

function toGift(questions) {
  return questions
    .map((q, idx) => {
      // Extract answer at the end: {...}
      const match = q.match(/^(.*)\{(TRUE|FALSE)\}$/i);
      if (!match) return ""; // skip malformed

      const [, body, answer] = match;
      const title = `Ερώτηση ${String(idx + 1).padStart(3, "0")}`;
      const giftAnswer = answer.toUpperCase() === "TRUE" ? "T" : "F";

      return `::${title}::[plain]${escapeGift(body)} {${giftAnswer}}`;
    })
    .join("\n\n");
}

// Main
const inputPath = process.argv[2]
  ? path.resolve(process.argv[2])
  : path.join(__dirname, "ΓΛυκείου1_3ΣΛ.txt");
const outputPath = "output.gift";

const input = fs.readFileSync(inputPath, "utf8");
const questions = parseQuestions(input);
const gift = toGift(questions);

fs.writeFileSync(outputPath, gift, "utf8");
console.log(`Exported ${questions.length} questions to ${outputPath}`);
