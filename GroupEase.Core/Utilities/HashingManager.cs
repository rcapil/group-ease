using System;
using System.Text;
using System.Security.Cryptography;

namespace GroupEase.Core.Utilities
{
    public enum HashAlgo
    {
        SHA256,
        SHA384,
        SHA512
    }

    public class HashingManager
    {
        public static string CreateSalt()
        {
            const int minSaltLength = 4;
            const int maxSaltLength = 16;
            var r = new Random();
            var saltLength = r.Next(minSaltLength, maxSaltLength);
            var rng = new RNGCryptoServiceProvider();
            var buffer = new byte[saltLength];

            rng.GetNonZeroBytes(buffer);
            rng.Dispose();

            return Convert.ToBase64String(buffer); 
        }
        public static string ComputeHash(string text, string salt, HashAlgo hashType)
        {
            byte[] bytes = ASCIIEncoding.UTF8.GetBytes(text + salt);
            byte[] hash = null;

            switch(hashType)
            {
                case HashAlgo.SHA256:
                    SHA256Managed sha256 = new SHA256Managed();
                    hash = sha256.ComputeHash(bytes);
                    sha256.Dispose();
                    break;
                case HashAlgo.SHA384:
                    SHA384Managed sha384 = new SHA384Managed();
                    hash = sha384.ComputeHash(bytes);
                    sha384.Dispose();
                    break;
                case HashAlgo.SHA512:
                    SHA512Managed sha512 = new SHA512Managed();
                    hash = sha512.ComputeHash(bytes);
                    sha512.Dispose();
                    break;
            }

            return Convert.ToBase64String(hash); 
        }

        public static bool Verify(string text, string salt, HashAlgo hashType, string saltedHash)
        {
            return saltedHash == ComputeHash(text, salt, hashType);
        }
    }
}
