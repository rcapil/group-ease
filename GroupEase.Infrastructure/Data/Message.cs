//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace GroupEase.Infrastructure.Data
{
    using System;
    using System.Collections.Generic;
    
    public partial class Message
    {
        public int messageId { get; set; }
        public System.Guid activityId { get; set; }
        public int userId { get; set; }
        public string body { get; set; }
        public System.DateTime timestamp { get; set; }
    
        public virtual Activity Activity { get; set; }
        public virtual User User { get; set; }
    }
}
