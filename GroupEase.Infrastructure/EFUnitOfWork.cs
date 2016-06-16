using GroupEase.Core.Interfaces.Repository;
using GroupEase.Infrastructure.Repository;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;

namespace GroupEase.Infrastructure
{
    public class EfUnitOfWork : IUnitOfWork
    {
        private readonly DbContext _context;
        private readonly Dictionary<Type, BaseGenericRepository> _dictionary;

        public EfUnitOfWork(DbContext context)
        {
            _context = context;
            _context.ChangeTracker.DetectChanges();
            _context.Configuration.AutoDetectChangesEnabled = true;
            _dictionary = new Dictionary<Type, BaseGenericRepository>();
        }

        private void Put<T>(EfRepositoryBase<T> item) where T : class
        {
            _dictionary[typeof(T)] = item;
        }

        private EfRepositoryBase<T> Get<T>() where T : class
        {
            if (_dictionary.ContainsKey(typeof(T)))
            {
                return _dictionary[typeof(T)] as EfRepositoryBase<T>;
            }

            var efr = new EfRepositoryBase<T>(_context);
            Put(efr);

            return efr;
        }

        public IRepository<T> GetRepository<T>() where T : class
        {
            return Get<T>();
        }

        public void SaveChanges()
        {
            _context.SaveChanges();
        }

        public void RollBack()
        {
            _context.ChangeTracker.DetectChanges();

            var entries = _context.ChangeTracker.Entries().Where(e => e.State != EntityState.Unchanged).ToList();

            foreach (var dbEntityEntry in entries)
            {
                var entity = dbEntityEntry.Entity;

                if (entity == null) continue;

                if (dbEntityEntry.State == EntityState.Added)
                {
                    var set = _context.Set(entity.GetType());
                    set.Remove(entity);
                }
                else if (dbEntityEntry.State == EntityState.Modified)
                {
                    _context.Entry(dbEntityEntry.Entity).CurrentValues.SetValues(_context.Entry(dbEntityEntry.Entity).OriginalValues);
                    _context.Entry(dbEntityEntry.Entity).State = EntityState.Unchanged;
                }
                else if (dbEntityEntry.State == EntityState.Deleted)
                    _context.Entry(dbEntityEntry).CurrentValues.SetValues(_context.Entry(dbEntityEntry).OriginalValues);
                dbEntityEntry.State = EntityState.Unchanged;
            }
        }

        public void Dispose()
        {
            _context.Dispose();
        }
    }
}
