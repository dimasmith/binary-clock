//
// Copyright 2016 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

using Toybox.WatchUi;

const bits = [
    [0, 0, 0, 0],
    [0, 0, 0, 1],
    [0, 0, 1, 0],
    [0, 0, 1, 1],
    [0, 1, 0, 0],
    [0, 1, 0, 1],
    [0, 1, 1, 0],
    [0, 1, 1, 1],
    [1, 0, 0, 0],
    [1, 0, 0, 1]
];

const size = 36;
const small_gap = 1;
const large_gap = 8;

class BinaryClockWatchFaceView extends WatchUi.WatchFace {

    function initialize() {
        WatchFace.initialize();
    }

    function onUpdate(dc) {
        var time = System.getClockTime();
        dc.setColor(Graphics.COLOR_BLUE, Graphics.COLOR_BLACK);
        dc.clear();
        
        var min_lo = time.min % 10;
        var min_hi = (time.min - min_lo) / 10;
        
        drawBars(dc, min_hi, min_lo, dc.getWidth() / 2 + size + large_gap);

        var hour_lo = time.hour % 10;
        var hour_hi = (time.hour - hour_lo) / 10;
        
        drawBars(dc, hour_hi, hour_lo, dc.getWidth() / 2 - size - large_gap);

        return true;
    }

    function drawBars(dc, hi, lo, x) {
        drawBar(dc, hi, x - size / 2 - small_gap);
        drawBar(dc, lo, x + size / 2 + small_gap);
    }

    function drawBar(dc, value, x) {        
        var b = bits[value];
        for(var i = 0; i < 4; i += 1) {
            if (b[i] == 1) {
                dc.fillRectangle(
                    x - size / 2 + 2, 
                    dc.getHeight() / 2 - (2 * size) + (i * size) + 2, 
                    size - 4,
                    size - 4
                    );
            }
            dc.drawRectangle(
                x - size / 2, 
                dc.getHeight() / 2 - (2 * size) + (i * size), 
                size,
                size
                );
        }
    }
}