//PUNCTA ANALYZER PLUGIN FOR COLOC. ANALYSIS - NEUROTOXINS RETROGRADE TRANSPORT
//Before running this macro convert to RGB the images and select the slice from which you want to start.
//Change the "Next SLice" command depending on how many slices you have in the z-stack.
//For colocalisation analysis you should analyse alternated slices (1yes, 1no, 1yes, 1no)


//10 slices, starting from the 2nd.

rename("Original")
run("RGB Color", "slices keep");
rename("RGB");
run("Select All");

run("Next Slice [>]");
//the plugin will run automatically, you need to SET THRESHOLDS AND COPY RESULTS
//2
run("Puncta Analyzer", "condition=[] red green size=8-1000 show=Outlines display exclude clear summarize add in_situ size=8-1000 show=Outlines display exclude clear summarize add in_situ");
//take note of the n° of RED, GREEN and COLOCALISED PUNCTA
waitForUser("Take note of the results and then press 'Ok'");

run("Next Slice [>]");
run("Next Slice [>]");
//4
run("Puncta Analyzer", "condition=[] red green size=8-1000 show=Outlines display exclude clear summarize add in_situ size=8-1000 show=Outlines display exclude clear summarize add in_situ");
waitForUser("Take note of the results and press 'Ok'");
run("Next Slice [>]");
run("Next Slice [>]");
//6
run("Puncta Analyzer", "condition=[] red green size=8-1000 show=Outlines display exclude clear summarize add in_situ size=8-1000 show=Outlines display exclude clear summarize add in_situ");
waitForUser("Take note of the results and press 'Ok'");

run("Next Slice [>]");
run("Next Slice [>]");
//8
run("Puncta Analyzer", "condition=[] red green size=8-1000 show=Outlines display exclude clear summarize add in_situ size=8-1000 show=Outlines display exclude clear summarize add in_situ");
waitForUser("Take note of the results and press 'Ok'");

run("Next Slice [>]");
run("Next Slice [>]");
//10
run("Puncta Analyzer", "condition=[] red green size=8-1000 show=Outlines display exclude clear summarize add in_situ size=8-1000 show=Outlines display exclude clear summarize add in_situ");
waitForUser("Take note of the results and press 'Ok'");


selectWindow("RGB");
close()
selectWindow("Original");
close()




//by C.Panzi - April 2020