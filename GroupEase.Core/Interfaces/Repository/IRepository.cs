using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace GroupEase.Core.Interfaces.Repository
{
    public interface IRepository<T> : IDisposable
    {
        IQueryable<T> GetAll();
        IQueryable<T> All { get; }
        T Add(T entity);
        void Delete(T entity);
        void Edit(T entity);
        void Upsert(T entity, Func<T, bool> insertExpression);
        void Save();
    }
}
