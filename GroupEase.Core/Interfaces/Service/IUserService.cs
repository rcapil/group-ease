using GroupEase.Core.Model;
using System;
using System.Collections.Generic;

namespace GroupEase.Core.Interfaces.Service
{
    public interface IUserService
    {
        IEnumerable<User> GetAllUsers();
        IEnumerable<User> SearchUsers(string query);
        IEnumerable<User> GetAllActivityUsers(Guid activityId);
        User GetUser(int userId);
        User CreateUser(User user);
        void DeleteUser(User user);
    }
}
