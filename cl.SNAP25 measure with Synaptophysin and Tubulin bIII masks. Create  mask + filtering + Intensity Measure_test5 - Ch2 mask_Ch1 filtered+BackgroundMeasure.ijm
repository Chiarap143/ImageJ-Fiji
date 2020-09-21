/* ANALYSIS OF DIFFERENT BoNT/A CONCENTRATION ACTIVITY IN CORTICAL NEURONS PRIMARY CULTURES

Macro to analyse how much cleaved SNAP-25 (cl.SNAP-25) is present in the same region 
of Synaptophysin (--> in synapses) + Tubulin.
Synaptophysin/tubulin is used as a mask to cut out the background signal for the cl.SNAP-25 signal.
then, the filtered synaptophysin/tubulin channel is used as a mask to further filter the cl.SNAP-25 signal and see how much of it is present at synaptic level.
3 channels: ch1= cl.SNAP-25(555), ch3= synaptophysin (647), ch2= tubulin bIII (488) 
Background measure: measure the area outside the synaptophysin/tubulin region in ch1

1. CREATE THE MASK
2. DUPLICATE CH1 AND MEASURE BACKGROUND NOISE
3. MULTIPLY CH1 FOR THE MASK
4. MEASURE THE INTENSITY
5. SAVE   

REPEAT FOR TUBULIN*/

fullname = File.name

run("Set Measurements...", "area mean min integrated display slice redirect=None decimal=4");
run("Misc...", "divide=NaN");
run("Clear Results");
setOption("BlackBackground", true);
setOption("DebugMode", true);

run("8-bit");

rename("Original - "+fullname);
Stack.setDisplayMode("composite"); //put together the 3 channels

/* 1. CREATE THE MASK

duplicate ch3 = synaptophysin */
run("Duplicate...", "duplicate channels=3"); 
rename("Ch3-Synatophysin - " +fullname);
saveAs("Tiff", "C:/Users/Chiara Panzi/Documents/PhD_UCL/IoN_DRI/Confocal images/March2020/19.03.20/Masks and channels/Ch2-Synatophysin - "+fullname);

setAutoThreshold("Default dark");
run("Threshold...");
waitForUser("Set threshold Synaptophysin"); //manually adjust the threshold
//create the Mask (0-255)
run("Convert to Mask", "method=Default background=Dark black");

//remove the background noise (points with radius <= 1 pixel) 
run("Median...", "radius=1 stack");
rename("Mask1 - "+fullname);

/*measure the black area = everything that is not synaptophysin (in this way the for loop 
does not stop when there is no synaptophysin channel, but it returns the whole area of the image)*/
for (n = 1; n <= nSlices; n++) {
    setSlice(n);
    run("Create Selection");
    roiManager("add"); 
    
}
roiManager("Measure");

//mask for synaptophysin
selectWindow("Mask1 - "+fullname);
run("Duplicate...", "duplicate");
run("Divide...", "value=255.0000 stack");
rename("Mask Synaptophysin - "+fullname);

/* 2. DUPLICATE CH1 AND MEASURE BACKGROUND NOISE 
repeat the same procedure done for ch1 for cl.SNAP-25 */

selectWindow("Original - "+fullname);
run("Duplicate...", "duplicate channels=1");
rename("Ch1 cl.SNAP25 - "+fullname);

//2.1 measure the background noise in Ch1 --> use the selections in the ROI manager (everything outside the area with synaptophysin signal)
run("Duplicate...", "duplicate");
rename("Ch1 background-mask1 selection - "+fullname);
roiManager("Measure");
//run("Measure Stack...");

saveAs("Tiff", "C:/Users/Chiara Panzi/OneDrive - University College London/PhD_UCL IoN-UKDRI/Analysis/Test BoNTA - Xeomin/Test1 March-June 2020/Masks and channels/Ch1 background-mask1 selection - "+fullname);


/* 3. MULTIPLY CH1 FOR THE MASK
multiply the filtered cl.SNAP25 for the Synaptophysin Mask */
selectWindow("Ch1 cl.SNAP25 - "+fullname);
imageCalculator("Multiply create stack", "Ch1 cl.SNAP25 - "+fullname,"Mask Synaptophysin - "+fullname);
selectWindow("Result of Ch1 cl.SNAP25 - "+fullname);
rename("cl.SNAP25 filtered Synaptophysin - "+fullname);

saveAs("Tiff", "C:/Users/Chiara Panzi/OneDrive - University College London/PhD_UCL IoN-UKDRI/Analysis/Test BoNTA - Xeomin/Test1 March-June 2020/Masks and channels/cl.SNAP-25 filtered Synaptophysin - "+ fullname);


// 4. MEASURE THE INTENSITY Of cl.SNAP-25 filtered with synaptophysin

run("Measure Stack...");
//waitForUser("Copy the results");
roiManager("Deselect");
roiManager("Delete");
  
// 5. SAVE all the file as Tiff
selectWindow("Mask1 - "+fullname);
saveAs("Tiff", "C:/Users/Chiara Panzi/OneDrive - University College London/PhD_UCL IoN-UKDRI/Analysis/Test BoNTA - Xeomin/Test1 March-June 2020/Masks and channels/Mask1 - "+fullname);
selectWindow("Mask Synaptophysin - "+fullname);
saveAs("Tiff", "C:/Users/Chiara Panzi/OneDrive - University College London/PhD_UCL IoN-UKDRI/Analysis/Test BoNTA - Xeomin/Test1 March-June 2020/Masks and channels/Mask Synaptophysin - "+fullname);


/*REPEAT EVERYTHING BUT USING TUBULIN BIII AS MASK  
  
  1. CREATE THE MASK

duplicate ch2 = Tubulin bIII */
selectWindow("Original - "+fullname);
run("Duplicate...", "duplicate channels=2");
rename("Ch2-Tubulin bIII - " +fullname);
saveAs("Tiff", "C:/Users/Chiara Panzi/Documents/PhD_UCL/IoN_DRI/Confocal images/March2020/19.03.20/Masks and channels/Ch3-Tubulin bIII - "+fullname);

setAutoThreshold("Default dark");
run("Threshold...");
waitForUser("Set threshold Tubulin bIII"); //manually adjust the threshold
//create the Mask (0-255)
run("Convert to Mask", "method=Default background=Dark black");

//remove the background noise (points with radius <= 1 pixel) 
run("Median...", "radius=1 stack");
rename("Mask2 - "+fullname);

/*measure the black area = everything that is not tubulin bIII (in this way the for loop 
does not stop when there is no synaptophysin channel, but it returns the whole area of the image)*/
for (n = 1; n <= nSlices; n++) {
    setSlice(n);
    run("Create Selection");
    roiManager("add"); 
    
}
roiManager("Measure");

//mask for tubulin bIII
selectWindow("Mask2 - "+fullname);
run("Duplicate...", "duplicate");
run("Divide...", "value=255.0000 stack");
rename("Mask Tubulin bIII - "+fullname);

/* 2. DUPLICATE CH1 AND MEASURE BACKGROUND NOISE 
repeat the same procedure done for ch1 for cl.SNAP-25 */

selectWindow("Ch1 cl.SNAP25 - "+fullname)

//2.1 measure the background noise in Ch1 --> use the selections in the ROI manager (everything outside the area with tubulin bIII signal)
run("Duplicate...", "duplicate");
rename("Ch1 background-mask2 selection - "+fullname);
roiManager("Measure");
//run("Measure Stack...");

saveAs("Tiff", "C:/Users/Chiara Panzi/OneDrive - University College London/PhD_UCL IoN-UKDRI/Analysis/Test BoNTA - Xeomin/Test1 March-June 2020/Masks and channels/Ch1 background-mask2 selection - "+fullname);


/* 3. MULTIPLY CH1 FOR THE MASK
multiply the filtered cl.SNAP25 for the Synaptophysin Mask */
selectWindow("Ch1 cl.SNAP25 - "+fullname);
imageCalculator("Multiply create stack", "Ch1 cl.SNAP25 - "+fullname,"Mask Tubulin bIII - "+fullname);
selectWindow("Result of Ch1 cl.SNAP25 - "+fullname);
rename("cl.SNAP25 filtered Tubulin bIII - "+fullname);
saveAs("Tiff", "C:/Users/Chiara Panzi/OneDrive - University College London/PhD_UCL IoN-UKDRI/Analysis/Test BoNTA - Xeomin/Test1 March-June 2020/Masks and channels/cl.SNAP-25 filtered Tubulin bIII - "+ fullname);


// 4. MEASURE THE INTENSITY Of cl.SNAP-25 filtered with synaptophysin

run("Measure Stack...");
waitForUser("Copy the results");
roiManager("Deselect");
roiManager("Delete");

/*5. SAVE */
selectWindow("Original - "+fullname);
saveAs("Tiff", "C:/Users/Chiara Panzi/OneDrive - University College London/PhD_UCL IoN-UKDRI/Analysis/Test BoNTA - Xeomin/Test1 March-June 2020/Masks and channels/Original - "+fullname);
selectWindow("Ch1 cl.SNAP25 - "+fullname);
saveAs("Tiff", "C:/Users/Chiara Panzi/OneDrive - University College London/PhD_UCL IoN-UKDRI/Analysis/Test BoNTA - Xeomin/Test1 March-June 2020/Masks and channels/Ch1 cl.SNAP25 - "+fullname);
selectWindow("Mask2 - "+fullname);
saveAs("Tiff", "C:/Users/Chiara Panzi/OneDrive - University College London/PhD_UCL IoN-UKDRI/Analysis/Test BoNTA - Xeomin/Test1 March-June 2020/Masks and channels/Mask2 - "+fullname);
selectWindow("Mask Tubulin bIII - "+fullname);
saveAs("Tiff", "C:/Users/Chiara Panzi/OneDrive - University College London/PhD_UCL IoN-UKDRI/Analysis/Test BoNTA - Xeomin/Test1 March-June 2020/Masks and channels/Mask Tubulin bIII - "+fullname);

run("Close All");

/* 13-05-2020_Chiara Panzi, PhD student (QSH and DRI)
Project "Modulation of the spread of pathological tau by botulinum neurotoxins"    */