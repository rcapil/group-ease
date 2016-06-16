using GroupEase.Core.Common;
using GroupEase.Core.Interfaces.Repository;
using System;
using System.Data.Entity;
using System.Linq;
using System.Linq.Expressions;

namespace GroupEase.Infrastructure.Repository
{
    public class EfRepositoryBase<T> : BaseGenericRepository, IRepository<T> where T : class
    {
        public EfRepositoryBase(DbContext context)
        {
            _entities = context;
        }

        public override Type Type
        {
            get { return typeof(T); }
        }

        private readonly DbContext _entities;

        public virtual DbContext GetContext()
        {
            return _entities;
        }

        public virtual IQueryable<T> All
        {
            get
            {
                return GetAll();
            }
        }

        public virtual IQueryable<T> GetAll()
        {

            IQueryable<T> query = _entities.Set<T>();
            return query;
        }

        public virtual T Add(T entity)
        {

            return _entities.Set<T>().Add(entity);
        }

        public virtual void Delete(T entity)
        {

            _entities.Set<T>().Remove(entity);
        }

        public virtual void Edit(T entity)
        {

            _entities.Entry(entity).State = EntityState.Modified;
        }

        public virtual void Upsert(T entity, Func<T, bool> insertExpression)
        {
            if (insertExpression.Invoke(entity))
            {
                Add(entity);
            }
            else
            {
                Edit(entity);
            }
        }

        public virtual void Save()
        {
            _entities.SaveChanges();
        }

        public virtual IQueryable<T> Fetch(Expression<Func<T, bool>> predicate)
        {
            return All.Where(predicate);
        }

        public int Count(Expression<Func<T, bool>> predicate)
        {
            return Fetch(predicate).Count();
        }

        public IQueryable<T> Fetch(Expression<Func<T, bool>> predicate, Action<Orderable<T>> order)
        {
            var orderable = new Orderable<T>(Fetch(predicate));
            order(orderable);
            return orderable.Queryable;
        }

        public IQueryable<T> Fetch(Expression<Func<T, bool>> predicate, Action<Orderable<T>> order, int skip, int count)
        {
            return Fetch(predicate, order).Skip(skip).Take(count);
        }

        public IQueryable<T> Fetch(Expression<Func<T, bool>> predicate, Action<Orderable<T>> order, int skip, int count, out int resultCount)
        {
            resultCount = Fetch(predicate).Count();
            return Fetch(predicate, order).Skip(skip).Take(count);
        }

        private bool _disposed = false;

        protected virtual void Dispose(bool disposing)
        {

            if (!this._disposed)
                if (disposing)
                    _entities.Dispose();

            this._disposed = true;
        }

        public void Dispose()
        {

            Dispose(true);
            GC.SuppressFinalize(this);
        }
    }
}
