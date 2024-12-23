using QRCoder;
using SkiaSharp;
using Svg.Skia;
using System;
using System.IO;

namespace API.Utilities
{
    public static class QrcodeGenrator
    {
        /// <summary>
        /// Generates a QR code, saves it to a specified file, and returns the file path.
        /// </summary>
        /// <param name="content">The content to encode in the QR code.</param>
        /// <param name="outputDirectory">The directory to save the QR code image.</param>
        /// <returns>The file path of the saved QR code image.</returns>
        public static string GenerateQrCode(string content, string outputDirectory , string fn)
        {
            if (string.IsNullOrWhiteSpace(content))
                throw new ArgumentException("Content cannot be null or empty.", nameof(content));

            if (string.IsNullOrWhiteSpace(outputDirectory))
                throw new ArgumentException("Output directory cannot be null or empty.", nameof(outputDirectory));

            // Ensure the output directory exists
            Directory.CreateDirectory(outputDirectory);

            // Generate a unique file name for the QR code
            string fileName = $"QRCode_{fn}.png";
            string filePath = Path.Combine(outputDirectory, fileName);

            using (QRCodeGenerator qrGenerator = new QRCodeGenerator())
            {
                QRCodeData qrCodeData = qrGenerator.CreateQrCode(content, QRCodeGenerator.ECCLevel.Q);
                using (var qrCode = new SvgQRCode(qrCodeData))
                {
                    // Get the SVG string
                    string svg = qrCode.GetGraphic(20);

                    // Convert SVG to SKBitmap using Svg.Skia
                    using (var stream = new MemoryStream(System.Text.Encoding.UTF8.GetBytes(svg)))
                    {
                        var skSvg = new SKSvg();
                        skSvg.Load(stream);

                        using (var bitmap = new SKBitmap((int)skSvg.Picture.CullRect.Width, (int)skSvg.Picture.CullRect.Height))
                        using (var canvas = new SKCanvas(bitmap))
                        {
                            canvas.DrawPicture(skSvg.Picture);
                            canvas.Flush();

                            // Save the image to the specified path
                            using (var fileStream = File.OpenWrite(filePath))
                            {
                                bitmap.Encode(fileStream, SKEncodedImageFormat.Png, 100);
                            }
                        }
                    }
                }
            }

            return filePath;
        }
    }
}
