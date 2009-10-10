using System;
using System.Collections.Generic;
using System.Text;

namespace D4D.Platform.Domain
{
    public class PagingContext
    {
        #region protected variables
        [NonSerialized()]
        protected int totalRecordCount = 0;
        [NonSerialized()]
        protected int recordsPerPage = 1;
        [NonSerialized()]
        protected int currentPageNumber = 1;
        [NonSerialized()]
        protected int pagesPerCluster = 5;
        [NonSerialized()]
        private int uniqueId = 0;
        [NonSerialized()]
        private int referringPageNumber = -1;
        [NonSerialized()]
        private int firstRecordInPreviousPage = -1;
        [NonSerialized()]
        private int lastRecordInPreviousPage = -1;

        #endregion

        #region Constructors

        public PagingContext() { }

        public PagingContext(int totalRecordCount, int recordsPerPage, int currentPageNumber)
        {
            TotalRecordCount = totalRecordCount;
            RecordsPerPage = recordsPerPage;
            CurrentPageNumber = currentPageNumber;
        }

        public PagingContext(int totalRecordCount, int recordsPerPage, int currentPageNumber, int uniqueId)
        {
            TotalRecordCount = totalRecordCount;
            RecordsPerPage = recordsPerPage;
            CurrentPageNumber = currentPageNumber;
            UniqueId = uniqueId;
        }
        #endregion

        #region Record Properties
        /// <summary>
        /// Defaults to 0 if not set.
        /// </summary>
        public int TotalRecordCount
        {
            get { return totalRecordCount; }
            set
            {
                totalRecordCount = value;
            }
        }

        public int RecordsPerPage
        {
            get { return recordsPerPage; }
            set { recordsPerPage = value; }
        }

        public int UniqueId
        {
            get { return uniqueId; }
            set { uniqueId = value; }
        }
        #endregion

        /// <summary>
        /// Defaults to -1 when not set
        /// </summary>
        public int FirstRecordInPreviousPage
        {
            get { return firstRecordInPreviousPage; }
            set { firstRecordInPreviousPage = value; }
        }

        /// <summary>
        /// Defaults to -1 when not set
        /// </summary>
        public int LastRecordInPreviousPage
        {
            get { return lastRecordInPreviousPage; }
            set { lastRecordInPreviousPage = value; }
        }

        #region Page Properties
        /// <summary>
        /// Page numbers begin at 1, not 0.
        /// CurrentPageNumber defaults to 1 if not set. 
        /// </summary>
        public int CurrentPageNumber
        {
            get { return currentPageNumber; }
            set
            {
                if (value <= 1)
                {
                    currentPageNumber = 1;
                }
                //else if (value > TotalPageCount)
                //{
                //    currentPageNumber = TotalPageCount;
                //}
                else
                {
                    currentPageNumber = value;
                }
            }
        }

        public int TotalPageCount
        {
            get
            {
                int count = DivideAndReturnCeiling(TotalRecordCount, RecordsPerPage);
                return (count > 0) ? count : 1;
            }
        }

        public int CurrentPageRecordCount
        {
            get
            {
                return CurrentPageEndRow - CurrentPageStartRow + 1;
            }
        }

        public int CurrentPageStartRow
        {
            get
            {
                if (CurrentPageNumber == 1)
                    return 1;
                return (CurrentPageNumber - 1) * RecordsPerPage + 1;
            }
        }

        public int CurrentPageEndRow
        {
            get
            {
                int endRow = CurrentPageStartRow + RecordsPerPage - 1;
                if (endRow > TotalRecordCount)
                    return TotalRecordCount;
                else
                    return endRow;
            }
        }

        public bool CurrentPageHasPrecedingPages
        {
            get
            {
                return (CurrentPageNumber != 1);
            }
        }

        public bool CurrentPageHasSucceedingPages
        {
            get
            {
                return (CurrentPageNumber != TotalPageCount);
            }
        }

        public int ReferringPageNumber
        {
            get { return referringPageNumber; }
            set { referringPageNumber = value; }
        }

        /// <summary>
        /// Difference between current page number and referring page number.
        /// </summary>
        public int PageJump
        {
            get { return CurrentPageNumber - ReferringPageNumber; }
        }

        /// <summary>
        /// Does not verify that page actually exists
        /// </summary>
        public int PrecedingPageNumber
        {
            get { return currentPageNumber - 1; }
        }

        /// <summary>
        /// Does not verify that page actually exists
        /// </summary>
        public int SucceedingPageNumber
        {
            get { return currentPageNumber + 1; }
        }
        #endregion

        #region Page Cluster properties

        public int PagesPerCluster
        {
            get { return pagesPerCluster; }
            set { pagesPerCluster = value; }
        }

        public int PageClusterCount
        {
            get
            {
                return DivideAndReturnCeiling(TotalPageCount, PagesPerCluster);
            }
        }

        public int CurrentPageCluster
        {
            get
            {
                return DivideAndReturnCeiling(CurrentPageNumber, PageClusterCount);
            }
        }

        public int Offset
        {
            get
            {
                return ((CurrentPageNumber % PagesPerCluster) == 0) ? PagesPerCluster : (CurrentPageNumber % PagesPerCluster);
            }
        }

        public int FirstPageInCurrentCluster
        {
            get
            {
                return CurrentPageNumber - Offset + 1;
            }
        }

        public int LastPageInCurrentCluster
        {
            get
            {
                return Math.Min(FirstPageInCurrentCluster + PagesPerCluster - 1, TotalPageCount);
            }
        }

        public static List<T> GetRecordsForCurrentPage<T>(PagingContext pager, List<T> allRecords)
        {
            int itemCount = pager.CurrentPageRecordCount;
            int firstIndex = pager.CurrentPageStartRow - 1;
            if (itemCount < 1 || firstIndex < 0 || allRecords.Count < itemCount + firstIndex)
            {
                pager.CurrentPageNumber = pager.TotalPageCount;
                itemCount = pager.CurrentPageRecordCount;
                firstIndex = pager.CurrentPageStartRow - 1;
            }
            return allRecords.GetRange(firstIndex, itemCount);
        }

        #endregion

        #region Helper Methods
        /// <returns>1 if given divisor is equal to zero</returns>
        protected int DivideAndReturnCeiling(int dividend, int divisor)
        {
            if (divisor == 0)
            {
                return 1;
            }
            double x = ((double)dividend / (double)divisor);
            return (int)Math.Ceiling(x);
        }
        #endregion
    }
}
