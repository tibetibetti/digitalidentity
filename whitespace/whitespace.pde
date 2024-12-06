import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioInput in;

PFont font;

// Variables for the textbox
float boxWidth = 300;
float boxHeight = 200;
float boxX, boxY; 
float targetBoxWidth = 300;
float targetBoxHeight = 200;

// Sensitivity threshold for detecting speaking
float sensitivity = 0.0001;

// Line spacing variables
float baseLineSpacing = 30; // Default spacing between lines
float currentLineSpacing = baseLineSpacing;

void setup() {
  size(1920, 1080);
  background(255);
  textAlign(CENTER, CENTER);
  rectMode(CENTER);

// Load a custom font
  font = loadFont("Almarai40.vlw"); // Replace with your font name
  textFont(font); // Set the font for text rendering

  // Initialize the textbox position
  boxX = width / 2;
  boxY = height / 2;

  // Set up audio input
  minim = new Minim(this);
  in = minim.getLineIn(Minim.MONO, 512);
}

void draw() {
  background(255); // Clear the background every frame

  // Analyze the audio to detect speaking
  float level = in.mix.level();
  if (level > sensitivity) {
    // Expand the textbox
    targetBoxWidth = min(width, targetBoxWidth + 20);
    targetBoxHeight = min(height, targetBoxHeight + 20);

    // Decrease the line spacing
    currentLineSpacing = max(5, currentLineSpacing - 1);
  } else {
    // Shrink the textbox
    targetBoxWidth = max(300, targetBoxWidth - 10);
    targetBoxHeight = max(200, targetBoxHeight - 10);

    // Reset the line spacing gradually
    currentLineSpacing = lerp(currentLineSpacing, baseLineSpacing, 0.1);
  }


  // Smoothly transition the size of the textbox
  boxWidth = lerp(boxWidth, targetBoxWidth, 0.1);
  boxHeight = lerp(boxHeight, targetBoxHeight, 0.1);

  // Draw the textbox
  fill(255);
  noStroke();
  rect(boxX, boxY, boxWidth, boxHeight);

  // Add the repeating text
  fill(0);
  textSize(20);
  textAlign(LEFT);
  String message = "White space is important. ";
  String fullText = message.repeat(500); // Repeat the message to ensure enough content

  float margin = 50; // Padding inside the textbox
  float x = boxX - boxWidth / 2 + margin;
  float y = boxY - boxHeight / 2 + margin;
  float maxY = boxY + boxHeight / 2 - margin; // Limit for the bottom of the textbox

  // Split the text into words and render it line by line
  String[] words = split(fullText, ' ');
  String currentLine = "";
  for (int i = 0; i < words.length; i++) {
    String testLine = currentLine + words[i] + " ";
    float testWidth = textWidth(testLine);
    if (testWidth > boxWidth - margin * 2) {
      // Line is too wide; render the current line
      text(currentLine.trim(), x, y);
      y += currentLineSpacing; // Move to the next line based on dynamic line spacing
      if (y > maxY) break; // Stop if we exceed the textbox height
      currentLine = words[i] + " ";
    } else {
      currentLine = testLine;
    }
  }

  // Render the last line if there's space
  if (y + currentLineSpacing <= maxY) {
    text(currentLine.trim(), x, y);
  }
}

void stop() {
  in.close();
  minim.stop();
  super.stop();
}
