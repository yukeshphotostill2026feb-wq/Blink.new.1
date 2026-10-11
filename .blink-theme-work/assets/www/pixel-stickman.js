(() => {
  const SCALE = 3;
  const WIDTH = 12;
  const HEIGHT = 16;
  const FRAME_TIME = 120;
  const COLOR = "#f4f2ec";

  const frames = [
    [
      "000011110000",
      "000111111000",
      "000111111000",
      "000011110000",
      "000001100000",
      "111111111110",
      "000011110000",
      "000011110000",
      "000011110000",
      "000011110000",
      "000110011000",
      "001100001100",
      "011000000110",
      "010000000010",
      "100000000001",
      "100000000001"
    ],
    [
      "000011110000",
      "000111111000",
      "000111111000",
      "000011110000",
      "000001100000",
      "000111100000",
      "001111110000",
      "000011110000",
      "000011110000",
      "000011110000",
      "000110011000",
      "001100001100",
      "001000001100",
      "001000011000",
      "001100110000",
      "000111000000"
    ],
    [
      "000011110000",
      "000111111000",
      "000111111000",
      "000011110000",
      "000001100000",
      "000001111000",
      "000011111100",
      "000011110000",
      "000011110000",
      "000011110000",
      "000110011000",
      "001100001100",
      "001100000100",
      "000110000100",
      "000011001100",
      "000000111000"
    ]
  ];

  function initializeStickman(container) {
    const canvas = container.querySelector("canvas");
    if (!canvas) {
      throw new Error("Pixel stickman component is missing its canvas.");
    }

    const context = canvas.getContext("2d", { alpha: true });
    if (!context) {
      throw new Error("Pixel stickman could not create a 2D canvas context.");
    }

    canvas.width = WIDTH * SCALE;
    canvas.height = HEIGHT * SCALE;
    context.imageSmoothingEnabled = false;

    function drawFrame(frame) {
      context.clearRect(0, 0, canvas.width, canvas.height);
      context.fillStyle = COLOR;

      for (let y = 0; y < HEIGHT; y++) {
        for (let x = 0; x < WIDTH; x++) {
          if (frame[y][x] === "1") {
            context.fillRect(x * SCALE, y * SCALE, SCALE, SCALE);
          }
        }
      }
    }

    let frameIndex = 0;
    let nextFrameTime = performance.now() + FRAME_TIME;

    function animate() {
      const now = performance.now();
      if (now >= nextFrameTime) {
        const elapsedFrames = Math.floor((now - nextFrameTime) / FRAME_TIME) + 1;
        frameIndex = (frameIndex + elapsedFrames) % frames.length;
        drawFrame(frames[frameIndex]);
        nextFrameTime += elapsedFrames * FRAME_TIME;
      }

      window.setTimeout(animate, Math.max(0, nextFrameTime - performance.now()));
    }

    drawFrame(frames[frameIndex]);
    window.setTimeout(animate, FRAME_TIME);
  }

  document.querySelectorAll(".pixel-stickman").forEach(initializeStickman);
})();
