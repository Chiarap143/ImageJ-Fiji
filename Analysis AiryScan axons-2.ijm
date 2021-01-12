/*
Before running this Macro, open and look at the image and decide the z-plane you want to analyse. You also may have to adjust the channels (ctl+C) to be able to see them.
This Macro will then make you select a region of the axon and create a selection on the Tau channel. You will use the selection to create a Histogram and note the standard deviation (STDV).
Use 3 times the STDV to create a new threshold and then analyse the particles --> you will obtain the number and characteristics of the sopts that have higher intensity in that channel.



*/ 

fullname = File.name;


setOption("DebugMode", true);
setOption("BlackBackground", true);
Stack.setDisplayMode("composite");
run("Set Measurements...", "area mean min integrated display redirect=None decimal=4");
run("Colors...", "foreground=white background=black selection=yellow");
run("Options...", "iterations=1 count=1 black");
run("Misc...", "divide=NaN");

run("Clear Results");


rename("Original - "+fullname);
selectWindow("Original - "+fullname);
//select the region of the axon you want to analyse
setTool("rectangle");
waitForUser("Select the region you want to analyse and then press ok");
saveAs("Tiff", "C:/Users/Chiara Panzi/Desktop/Fiji Analysis - desktop/Tau Axons/Original - "+fullname);
run("Duplicate...", "title=[Axon area]");
rename("Axon area - "+fullname); 
run("Duplicate...", "duplicate channels=1"); 
rename("Ch1-hTau - " +fullname);

//create the selection on tau channel
selectWindow("Ch1-hTau - " +fullname);
run("Duplicate...", "duplicate");
run("In [+]");
run("In [+]");
run("8-bit");
//set the threshold --> wider is better 
run("Threshold...");
waitForUser("Adjust the threshold and take note");
run("Convert to Mask", "method=Default background=Default black");
run("Median...", "radius=1 stack");
run("Convert to Mask", "method=Default background=Default black");
run("Create Selection");
roiManager("Add");

run("Divide...", "value=255.0000 stack");

rename("hTAU mask1 - " +fullname);
run("Duplicate...", "duplicate");
saveAs("Tiff", "C:/Users/Chiara Panzi/Desktop/Fiji Analysis - desktop/Tau Axons/hTau mask - " +fullname);
selectWindow("hTAU mask1 - " +fullname);
imageCalculator("Multiply create", "Ch1-hTau - " +fullname, "hTAU mask1 - " +fullname);
rename("Ch1-hTau filtered - " +fullname);
/*run("Duplicate...", "duplicate");
run("In [+]");
run("In [+]");
run("Threshold...");
waitForUser("Adjust the threshold as before");
run("Convert to Mask", "method=Default background=Default black");
rename("hTAU mask1 selection - " +fullname);
run("Create Selection");
roiManager("Add");
//aggiungi measure per conoscere l'area*/



//Histogram on the selection + new threshold set as 3*STDV
selectWindow("Ch1-hTau filtered - " +fullname);
run("Duplicate...", "duplicate");
rename("hTau mask2 - " +fullname);
roiManager("Select", 0);
run("Histogram", "slice");
waitForUser("Take note of the STDV");
selectWindow("hTau mask2 - " +fullname);
run("Threshold...");
waitForUser("set the threshold as 3*STDV");
run("Convert to Mask");

saveAs("Tiff", "C:/Users/Chiara Panzi/Desktop/Fiji Analysis - desktop/Tau Axons/hTau mask2 - "+fullname);
run("Analyze Particles...", "display exclude summarize in_situ");
run("Create Selection");
roiManager("Add");
selectWindow("Ch1-hTau - "+fullname);
saveAs("Tiff", "C:/Users/Chiara Panzi/Desktop/Fiji Analysis - desktop/Tau Axons/Ch1-hTau - "+fullname);

//Repeat the same procedure for the EGFP channel (here ch2), but always using the selection created with the hTau channel (here ch1)

//Histogram on the selection + new threshold set as 3*STDV
selectWindow("Axon area - "+fullname); 
run("Duplicate...", "duplicate channels=2");
rename("Ch2-EGFP - " +fullname);
run("Duplicate...", "duplicate");
imageCalculator("Multiply create", "Ch2-EGFP - " +fullname, "hTAU mask1 - " +fullname);
rename("Ch2-EGFP filtered - " +fullname);

run("Duplicate...", "duplicate");
rename("EGFP mask2 - " +fullname);
roiManager("Select", 0);
run("Histogram", "slice");
waitForUser("Take note of the STDV");
selectWindow("EGFP mask2 - " +fullname);
run("Threshold...");
waitForUser("set the threshold as 3*STDV");
run("Convert to Mask");

saveAs("Tiff", "C:/Users/Chiara Panzi/Desktop/Fiji Analysis - desktop/Tau Axons/EGFP mask2 - "+fullname);
run("Analyze Particles...", "display exclude summarize in_situ");
run("Create Selection");
roiManager("Add");

selectWindow("Ch2-EGFP - "+fullname);
saveAs("Tiff", "C:/Users/Chiara Panzi/Desktop/Fiji Analysis - desktop/Tau Axons/Ch2-EGFP - "+fullname);

//Repeat the same procedure for the tubulin channel (here ch3), but always using the selection created with the hTau channel (here ch1)

//Histogram on the selection + new threshold set as 3*STDV
selectWindow("Axon area - "+fullname); 
run("Duplicate...", "duplicate channels=3");
rename("Ch3-bIII tubulin - " +fullname);
run("Duplicate...", "duplicate");
imageCalculator("Multiply create stack", "Ch3-bIII tubulin - " +fullname, "hTAU mask1 - " +fullname);
rename("Ch3-bIII tubulin filtered - " +fullname);

run("Duplicate...", "duplicate");
rename("Tubulin mask2 - " +fullname);
roiManager("Select", 0);
run("Histogram", "slice");
waitForUser("Take note of the STDV");
selectWindow("Tubulin mask2 - " +fullname);
run("Threshold...");
waitForUser("set the threshold as 3*STDV");
run("Convert to Mask");

saveAs("Tiff", "C:/Users/Chiara Panzi/Desktop/Fiji Analysis - desktop/Tau Axons/Tubulin mask2 - "+fullname);
run("Analyze Particles...", "display exclude summarize in_situ");
run("Create Selection");
roiManager("Add");

run("Clear Results");
roiManager("Deselect");
selectWindow("hTAU mask1 - " +fullname);
roiManager("Select", 0);
run("Measure");
selectWindow("Ch1-hTau filtered - " +fullname);
roiManager("Select", 1);
run("Measure");
selectWindow("Ch2-EGFP filtered - " +fullname);
roiManager("Select", 2);
run("Measure");
selectWindow("Ch3-bIII tubulin filtered - " +fullname);
roiManager("Select", 3);
run("Measure");



selectWindow("Ch2-EGFP filtered - " +fullname);
saveAs("Tiff", "C:/Users/Chiara Panzi/Desktop/Fiji Analysis - desktop/Tau Axons/Ch2-EGFP filtered - " +fullname);
selectWindow("Ch1-hTau filtered - " +fullname);
saveAs("Tiff", "C:/Users/Chiara Panzi/Desktop/Fiji Analysis - desktop/Tau Axons/Ch1-hTau filtered - " +fullname);

selectWindow("Ch3-bIII tubulin filtered - " +fullname);
saveAs("Tiff", "C:/Users/Chiara Panzi/Desktop/Fiji Analysis - desktop/Tau Axons/Ch3-bIII tubulin filtered - " +fullname);
selectWindow("Ch3-bIII tubulin - " +fullname);
saveAs("Tiff", "C:/Users/Chiara Panzi/Desktop/Fiji Analysis - desktop/Tau Axons/Ch3-bIII tubulin - " +fullname);
selectWindow("Axon area - "+fullname); 
saveAs("Tiff", "C:/Users/Chiara Panzi/Desktop/Fiji Analysis - desktop/Tau Axons/Axon area - " +fullname);

waitForUser("Save the results and summary data");
roiManager("Deselect");
roiManager("Delete");

run("Close All");
