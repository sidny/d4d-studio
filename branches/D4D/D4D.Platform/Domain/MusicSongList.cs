using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace D4D.Platform.Domain
{
    public class MusicSongList : BaseD4DDomain
    {
       
        public MusicSongList() { }
        public MusicSongList(int listId)
        {
            ListId = listId;
        }

        public int ListId
        {
            get;
            set;
        }
        public int MusicId
        {
            get;
            set;
        }

        public string SongName
        {
            get;
            set;
        }

        public string SongFile
        {
            get;
            set;
        }

        public string SongTime
        {
            get;
            set;
        }        

       

        public int Status
        {
            get;
            set;
        }
    }
}
