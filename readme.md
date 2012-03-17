# Final Cut Pro X Marker Converter

FCPX currently doesn't export markers to Compressor... super lame! This app converts markers from a .fcpxml file to a .txt file that can be imported into compressor.

## Usage

### Export project xml file
In the Final Cut Pro X project browser, highlight a project and select "File" => "Export XML".

### Convert .fcpxml to markers.txt

Option 1 - Open Markers.app. Select your .fcpxml file. Save your markers text file

Option 2 - Drag your .fcpxml file onto the Markers.app icon. You'll be asked where to save the markers text file.

### Compressor Error Calibration

Some users experience a slight timing error when importing markers into compressor - especially when converting very long projects. If your markers are slightly off, select "Yes" to the dialog.

### Import into Compressor

In the Compressor preview window, click the marker button and select "Import Chapter Marker List". Select your markers text file, and BOOM! Markers imported. 

## Known issues

Due to an issue with the way FCPX deals with unused clips, It's recommended that you create your markers as the final step in your workflow. Not doing so can result in markers being duplicated.


## Notes
This app finds all markers within the entire project, even those within compound clips.

Please post any issues - better yet, send a pull request!