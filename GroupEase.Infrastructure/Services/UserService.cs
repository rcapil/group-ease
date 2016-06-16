using GroupEase.Core.Interfaces.Service;
using System;
using System.Collections.Generic;
using GroupEase.Core.Model;
using GroupEase.Core.Interfaces.Repository;
using EF = GroupEase.Infrastructure.Data;
using AutoMapper;
using System.Linq;

namespace GroupEase.Infrastructure.Services
{
    public class UserService : IUserService
    {
        private readonly IRepository<EF.User> _userRepo;
        private readonly IRepository<EF.Member> _memberRepo;

        public UserService(IUnitOfWork unitOfWork)
        {
            _userRepo = unitOfWork.GetRepository<EF.User>();
            _memberRepo = unitOfWork.GetRepository<EF.Member>();
        }

        public User CreateUser(User user)
        {
            Mapper.Initialize(cfg => cfg.CreateMap<User, EF.User>().ReverseMap());

            var destObj = Mapper.Map<EF.User>(user);
            var efObj = _userRepo.Add(destObj);

            _userRepo.Save();

            return Mapper.Map<User>(efObj);
        }

        public void DeleteUser(User user)
        {
            var existingUser = _userRepo.All.FirstOrDefault(u => u.userId == user.UserId);

            _userRepo.Delete(existingUser);
            _userRepo.Save();
        }

        public IEnumerable<User> GetAllActivityUsers(Guid activityId)
        {
            var users = new List<User>();
            var activityMembers = _memberRepo.All.Where(m => m.activityId == activityId).ToList();

            foreach (var a in activityMembers)
            {
                users.Add(Mapper.Map<User>(a.User));
            }

            return users;
        }

        public IEnumerable<User> GetAllUsers()
        {
            return Mapper.Map<IEnumerable<User>>(_userRepo.GetAll().ToList());
        }

        public User GetUser(int userId)
        {
            var user = Mapper.Map<User>(_userRepo.All.Where(u => u.userId == userId).FirstOrDefault());

            return user;
        }

        public IEnumerable<User> SearchUsers(string query)
        {
            throw new NotImplementedException();
        }
    }
}
