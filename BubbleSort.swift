
// Reads lines of numbers from input.txt, sorts each line
// with bubble sort, and writes the results to output.txt.
//
// Author: MFROB
// Version: 1.0
// Since: 2026-11-12

import Foundation

/// Sorts an array of integers using bubble sort.
///
/// - Parameter listOfNum: the array to sort
/// - Returns: a new sorted array
func bubbleSort(_ listOfNum: [Int]) -> [Int] {
    // Make a mutable copy, because Swift function parameters are constants.
    var list = listOfNum

    // "end" is where the unsorted part stops.
    // Everything at or after "end" is already in its final place.
    var end = list.count

    // Tracks whether any swap happened during a pass.
    // Starts true so the loop runs at least once.
    var swapped = true

    // Keep making passes until a full pass has no swaps.
    while swapped {
        // Assume sorted until a swap proves otherwise.
        swapped = false

        // Compare each pair of neighbours in the unsorted part.
        // The guard avoids an invalid range when the list has 0 or 1 items.
        if end > 1 {
            for i in 0..<(end - 1) {
                // If the left number is bigger, the pair is out of order.
                if list[i] > list[i + 1] {
                    // Swap the pair. Swift can swap two elements directly.
                    list.swapAt(i, i + 1)

                    // Remember that we changed something this pass.
                    swapped = true
                }
            }
        }

        // The largest number of this pass has "bubbled" to the end,
        // so the next pass can skip it.
        end -= 1
    }
    return list
}

// ---- Main program ----

let inputPath = "input.txt"
let outputPath = "output.txt"

// Read the whole input file into one string.
guard let contents = try? String(contentsOfFile: inputPath, encoding: .utf8) else {
    print("Could not read \(inputPath)")
    exit(1)
}

// Holds one sorted line of text for each input line.
var results: [String] = []

// Split the file into lines and process each one separately.
for line in contents.components(separatedBy: .newlines) {
    // Remove extra whitespace at the ends of the line.
    let trimmed = line.trimmingCharacters(in: .whitespaces)

    // Skip blank lines (assume otherwise valid input).
    if trimmed.isEmpty {
        continue
    }

    // Split on spaces and convert each piece to an Int.
    // compactMap drops anything that is not a valid number.
    let numbers = trimmed
        .split(separator: " ")
        .compactMap { Int($0) }

    // Sort the numbers on this line.
    let sorted = bubbleSort(numbers)

    // Join the sorted numbers back into one space-separated line.
    results.append(sorted.map { String($0) }.joined(separator: " "))
}

// Write all sorted lines to output.txt, one per line.
let output = results.joined(separator: "\n") + "\n"
do {
    try output.write(toFile: outputPath, atomically: true, encoding: .utf8)
    print("Done. See \(outputPath)")
} catch {
    print("Could not write \(outputPath)")
}