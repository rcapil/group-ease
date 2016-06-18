using System;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using GroupEase.Core.Utilities;

namespace GroupEase.Core.UnitTests
{
    [TestClass]
    public class HashingManagerTests
    {
        [TestMethod]
        public void CreateSalt_Does_Not_Generate_Null()
        {
            // Arrange
            var salt = HashingManager.CreateSalt();

            // Assert
            Assert.IsNotNull(salt);
        }

        [TestMethod]
        public void ComputeHash_SHA256_Generate_A_String()
        {
            // Arrange
            var salt = HashingManager.CreateSalt();
            var plainText = "Password1!";

            // Act
            var hash = HashingManager.ComputeHash(plainText, salt, HashAlgo.SHA256);

            // Assert
            Assert.IsInstanceOfType(hash, typeof(string));
        }

        [TestMethod]
        public void ComputeHash_SHA384_Generate_A_String()
        {
            // Arrange
            var salt = HashingManager.CreateSalt();
            var plainText = "Password1!";

            // Act
            var hash = HashingManager.ComputeHash(plainText, salt, HashAlgo.SHA384);

            // Assert
            Assert.IsInstanceOfType(hash, typeof(string));
        }

        [TestMethod]
        public void ComputeHash_SHA512_Generate_A_String()
        {
            // Arrange
            var salt = HashingManager.CreateSalt();
            var plainText = "Password1!";

            // Act
            var hash = HashingManager.ComputeHash(plainText, salt, HashAlgo.SHA512);

            // Assert
            Assert.IsInstanceOfType(hash, typeof(string));
        }

        [TestMethod]
        public void Calling_CreateSalt_Consecutively_Generates_Different_Salt_Strings()
        {
            // Arrange
            var salt1 = HashingManager.CreateSalt();
            var salt2 = HashingManager.CreateSalt();

            // Assert
            Assert.AreNotEqual(salt1, salt2);
        }

        [TestMethod]
        public void Same_Plain_Text_Salted_Will_Generate_Different_Salted_Hash()
        {
            // Arrange
            var plainText = "Password1!";

            // Act
            var user1Hash = HashingManager.ComputeHash(plainText, HashingManager.CreateSalt(), HashAlgo.SHA256);
            var user2Hash = HashingManager.ComputeHash(plainText, HashingManager.CreateSalt(), HashAlgo.SHA256);

            // Assert
            Assert.AreNotEqual(user1Hash, user2Hash);
        }

        [TestMethod]
        public void Same_Salt_And_Same_PlainText_Returns_Verify_True()
        {
            // Arrange
            var salt = HashingManager.CreateSalt();
            var plainText = "Password1!";

            // Act
            var saltedHash = HashingManager.ComputeHash(plainText, salt, HashAlgo.SHA256);
            var verify = HashingManager.Verify(plainText, salt, HashAlgo.SHA256, saltedHash);

            // Assert
            Assert.IsTrue(verify);
        }

        [TestMethod]
        public void Same_Salt_And_Different_PlainText_Returns_Verify_False()
        {
            // Arrange
            var salt = HashingManager.CreateSalt();
            var originalPlainText = "Password1!";
            var differentPlainText = "Password2!";

            // Act
            var saltedHash = HashingManager.ComputeHash(originalPlainText, salt, HashAlgo.SHA256);
            var verify = HashingManager.Verify(differentPlainText, salt, HashAlgo.SHA256, saltedHash);

            // Assert
            Assert.IsFalse(verify);
        }
    }
}
