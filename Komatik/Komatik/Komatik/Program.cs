using System;
using static Komatik.ConsolePrinter;
using System.IO;


namespace Komatik {
    class Program {
        
        static void Main(string[] args) {

            // checking command line arguments presence
            if (args.Length == 0) {
                PrintNoArgsMessage();
            }
            else {
                // parsing first arg, supposedly a filename
                var fileNameInDebugDir = args[0];
                StreamReader streamReader = null;

                // checking file presence
                if (!File.Exists(fileNameInDebugDir)) {
                    PrintFileNotFoundMessage();
                }
                // file was found, processing with data operations
                else {
                    // read entire file line-by-line
                    try {
                        // Attempt to open a file. It will throw an exception if fails,
                        // hence try-catch block.
                        streamReader = new StreamReader(fileNameInDebugDir);
                        var receiveRate = "Receive rate"; // download rate from production
                        var savingRate = "Saving rate"; // upload rate to the target 
                        string lineData;
                        while ((lineData = streamReader.ReadLine()) != null) {

                            var linesInLog = lineData.Split('\n');
                            for (var line = 0; line < linesInLog.Length; line++) {
                                var logLine = linesInLog[line];
                                Console.WriteLine(logLine);
                            }
                        }
                    }
                    catch (Exception ex) {
                        PrintExceptionMessage(ex);
                    }
                    // closing stream reader so that file lock is released.
                    finally {
                        streamReader.Close();
                    }
                }


                // Keep the console window open, if required.
                // PressKeyToExit();
            }
        }
    }
}