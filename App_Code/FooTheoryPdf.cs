using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using iTextSharp.text.pdf;
using Kalboard360.ClassCode;
using Rectangle = iTextSharp.text.Rectangle;

/// <summary>
/// Summary description for FooTheoryPdf
/// </summary>
public class FooTheoryPdf
{
    /// <summary>
    /// Method that will utilize iTextSharp to write the <see cref="stringToWriteToPdf"/> to the 
    /// pdf on each page of the PDF.
    /// </summary>
    /// <param name="sourceFile">The PDf File</param>
    /// <param name="stringToWriteToPdf">The text to write to the pdf</param>
    /// <returns>The bytes of the newly updated PDF with <see cref="stringToWriteToPdf"/> in the pdf.</returns>
    public static byte[] WriteToPdf(FileInfo sourceFile, string stringToWriteToPdf)
    {
        PdfReader reader = new PdfReader(sourceFile.FullName);

        using (MemoryStream memoryStream = new MemoryStream())
        {
            //
            // PDFStamper is the class we use from iTextSharp to alter an existing PDF.
            //
            PdfStamper pdfStamper = new PdfStamper(reader, memoryStream);

            for (int i = 1; i <= reader.NumberOfPages; i++) // Must start at 1 because 0 is not an actual page.
            {
                //
                // If you ask for the page size with the method getPageSize(), you always get a
                // Rectangle object without rotation (rot. 0 degrees)—in other words, the paper size
                // without orientation. That’s fine if that’s what you’re expecting; but if you reuse
                // the page, you need to know its orientation. You can ask for it separately with
                // getPageRotation(), or you can use getPageSizeWithRotation(). - (Manning Java iText Book)
                //   
                //
                Rectangle pageSize = reader.GetPageSizeWithRotation(i);

                //
                // Gets the content ABOVE the PDF, Another option is GetUnderContent(...)  
                // which will place the text below the PDF content. 
                //
                PdfContentByte pdfPageContents = pdfStamper.GetOverContent(i);
                pdfPageContents.BeginText(); // Start working with text.

                //
                // Create a font to work with 
                //
                BaseFont baseFont = BaseFont.CreateFont(BaseFont.HELVETICA_BOLD, Encoding.ASCII.EncodingName, false);
                pdfPageContents.SetFontAndSize(baseFont, 20); // 40 point font
                pdfPageContents.SetRGBColorFill(170, 170, 170); // Sets the color of the font, RED in this instance


                //
                // Angle of the text. This will give us the angle so we can angle the text diagonally 
                // from the bottom left corner to the top right corner through the use of simple trigonometry. 
                //
                float textAngle =
                    (float)FooTheoryMath.GetHypotenuseAngleInDegreesFrom(pageSize.Height, pageSize.Width);

                //
                // Note: The x,y of the Pdf Matrix is from bottom left corner. 
                // This command tells iTextSharp to write the text at a certain location with a certain angle.
                // Again, this will angle the text from bottom left corner to top right corner and it will 
                // place the text in the middle of the page. 
                //
                pdfPageContents.ShowTextAligned(PdfContentByte.ALIGN_CENTER, stringToWriteToPdf,
                                                pageSize.Width / 2,
                                                pageSize.Height / 2,
                                                textAngle);

                pdfPageContents.EndText(); // Done working with text
            }
            pdfStamper.FormFlattening = true; // enable this if you want the PDF flattened. 
            pdfStamper.Close(); // Always close the stamper or you'll have a 0 byte stream. 


            return memoryStream.ToArray();
        }
    }
}