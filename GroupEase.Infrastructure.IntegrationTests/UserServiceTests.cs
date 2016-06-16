using GroupEase.Infrastructure.Services;
using GroupEase.Infrastructure.Data;
using Dto = GroupEase.Core.Model;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace GroupEase.Infrastructure.IntegrationTests
{
    [TestClass]
    public class UserServiceTests
    {
        [TestMethod]
        public void CreateUser_Returns_New_User()
        {
            // Arrange
            var userService = new UserService(new EfUnitOfWork(new GroupEaseEntities()));
            var user = new Dto.User
            {
                UserName = "rcapil",
                FirstName = "Richard",
                LastName = "Capil",
                Email = "richardcapil@gmail.com",
                Salt = "Test",
                SaltedHash = "SaltedTest"
            };

            // Act
            var createdUser = userService.CreateUser(user);

            // Assert
            Assert.IsNotNull(createdUser);
            userService.DeleteUser(createdUser);
        }

        [TestMethod]
        public void DeleteUser_Removes_User_From_Db()
        {
            // Arrange
            var userService = new UserService(new EfUnitOfWork(new GroupEaseEntities()));
            var user = new Dto.User
            {
                UserName = "rcapil",
                FirstName = "Richard",
                LastName = "Capil",
                Email = "richardcapil@gmail.com",
                Salt = "Test",
                SaltedHash = "SaltedTest"
            };

            // Act
            var userToDelete = userService.CreateUser(user);
            userService.DeleteUser(userToDelete);

            // Assert
            var u = userService.GetUser(userToDelete.UserId);
            Assert.IsNull(u);
        }
    }
}
