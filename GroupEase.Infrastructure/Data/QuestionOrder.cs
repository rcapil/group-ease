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
    
    public partial class QuestionOrder
    {
        public int questionId { get; set; }
        public int surveyId { get; set; }
        public Nullable<int> sortOrder { get; set; }
    
        public virtual Question Question { get; set; }
        public virtual Survey Survey { get; set; }
    }
}
