{
Article: Your first MP3 Delphi player

http://delphi.about.com/library/weekly/aa112800a.htm

See how to build a full-blown mp3 player with Delphi
in just a few seconds. Even more: get the ID3 tag
information from a mp3 file and change it!

For the .zip file of this project click here.

}


unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, MPlayer, ComCtrls, ExtCtrls, Gauges, FileCtrl, mmsystem,
  Menus, ShellApi, gbTrayIcon;

type
  TForm1 = class(TForm)
    mp3player: TMediaPlayer;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    ProgresTimer: TTimer;
    OpenDialog: TOpenDialog;
    progressbar: TGauge;
    TrackBar1: TTrackBar;
    Edit1: TEdit;
    GotoPosition: TButton;
    Label7: TLabel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    DirectoryListBox: TDirectoryListBox;
    DriveComboBox: TDriveComboBox;
    FileListBox: TFileListBox;
    TabSheet3: TTabSheet;
    RecentPlayList: TListBox;
    Label8: TLabel;
    edtitle: TStaticText;
    edartist: TStaticText;
    edalbum: TStaticText;
    edyear: TStaticText;
    edgenre: TStaticText;
    edcomment: TStaticText;
    BitBtn1: TBitBtn;
    TrackBar2: TTrackBar;
    Label9: TLabel;
    TabSheet4: TTabSheet;
    Panel1: TPanel;
    VideoPanel: TPanel;
    ComboBox1: TComboBox;
    MainMenu: TMainMenu;
    Properties1: TMenuItem;
    Sound1: TMenuItem;
    CD1: TMenuItem;
    PlayCD: TMenuItem;
    About1: TMenuItem;
    Exit1: TMenuItem;
    Volume1: TMenuItem;
    ClearList1: TMenuItem;
    Minimize1: TMenuItem;
    CheckBox1: TCheckBox;
    Label10: TLabel;
    spdbtn1: TSpeedButton;
    TabSheet5: TTabSheet;
    Memo1: TMemo;
    StaticText1: TStaticText;
    BitBtn2: TBitBtn;
    Edit2: TEdit;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    StaticText2: TStaticText;
    gbTrayIcon1: TgbTrayIcon;
    PopupMenuTrayIcon: TPopupMenu;
    ShowmainApp: TMenuItem;
    TrayPauseRestore: TMenuItem;
    Exit2: TMenuItem;
    btnRandom: TButton;
    Button1: TButton;
    TabSheet6: TTabSheet;
    Button2: TButton;
    Memo2: TMemo;
    PopupMenurandom: TPopupMenu;
    mnuSaveThisList: TMenuItem;
    mnuLoadFromList: TMenuItem;
    procedure ProgresTimerTimer(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure TrackBar1Change(Sender: TObject);
    procedure DirectoryListBoxChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure RecentPlayListOmid(Sender: TObject);
    procedure GotoPositionClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure TabSheet2Enter(Sender: TObject);
    procedure RecentPlayListKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TabSheet1Enter(Sender: TObject);
    procedure TrackBar2Change(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox1KeyPress(Sender: TObject; var Key: Char);
    procedure Sound1Click(Sender: TObject);
    procedure PlayCDClick(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure ShowCdStatus;
    procedure Volume1Click(Sender: TObject);
    procedure Minimize1Click(Sender: TObject);
    procedure ClearList1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure mp3playerNotify(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure spdbtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure ShowmainAppClick(Sender: TObject);
    procedure TrayPauseRestoreClick(Sender: TObject);
    procedure Exit2Click(Sender: TObject);
    procedure btnRandomClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure mnuSaveThisListClick(Sender: TObject);
    procedure mnuLoadFromListClick(Sender: TObject);
  private
    procedure FormIsMinimized(Sender: Tobject);
    procedure FormIsRestored(sender: Tobject);
    //procedure WMDeviceChange(var Msg: TMessage); message WM_DEVICECHANGE;

    { Private declarations }
  public
    { Public declarations }
  end;
cc=class(TMediaPlayer);

var  Form1: TForm1;
     songlist : tstringlist;
const flag1 : byte=0;
      indirect : boolean=false;
      internalflag1 : boolean=false;
      internalflag2 : boolean=false;
type
  TID3Rec = packed record
    Tag     : array[0..2] of Char;
    Title,
    Artist,
    Comment,
    Album   : array[0..29] of Char;
    Year    : array[0..3] of Char;
    Genre   : Byte;
  end;

  HMSRec = record
    Hours: byte;
    Minutes: byte;
    Seconds: byte;
    NotUsed: byte;
  end;

const
  MaxID3Genre=147;
  ID3Genre: array[0..MaxID3Genre] of string = (
    'Blues', 'Classic Rock', 'Country', 'Dance', 'Disco', 'Funk', 'Grunge',
    'Hip-Hop', 'Jazz', 'Metal', 'New Age', 'Oldies', 'Other', 'Pop', 'R&B',
    'Rap', 'Reggae', 'Rock', 'Techno', 'Industrial', 'Alternative', 'Ska',
    'Death Metal', 'Pranks', 'Soundtrack', 'Euro-Techno', 'Ambient',
    'Trip-Hop', 'Vocal', 'Jazz+Funk', 'Fusion', 'Trance', 'Classical',
    'Instrumental', 'Acid', 'House', 'Game', 'Sound Clip', 'Gospel',
    'Noise', 'AlternRock', 'Bass', 'Soul', 'Punk', 'Space', 'Meditative',
    'Instrumental Pop', 'Instrumental Rock', 'Ethnic', 'Gothic',
    'Darkwave', 'Techno-Industrial', 'Electronic', 'Pop-Folk',
    'Eurodance', 'Dream', 'Southern Rock', 'Comedy', 'Cult', 'Gangsta',
    'Top 40', 'Christian Rap', 'Pop/Funk', 'Jungle', 'Native American',
    'Cabaret', 'New Wave', 'Psychadelic', 'Rave', 'Showtunes', 'Trailer',
    'Lo-Fi', 'Tribal', 'Acid Punk', 'Acid Jazz', 'Polka', 'Retro',
    'Musical', 'Rock & Roll', 'Hard Rock', 'Folk', 'Folk-Rock',
    'National Folk', 'Swing', 'Fast Fusion', 'Bebob', 'Latin', 'Revival',
    'Celtic', 'Bluegrass', 'Avantgarde', 'Gothic Rock', 'Progressive Rock',
    'Psychedelic Rock', 'Symphonic Rock', 'Slow Rock', 'Big Band',
    'Chorus', 'Easy Listening', 'Acoustic', 'Humour', 'Speech', 'Chanson',
    'Opera', 'Chamber Music', 'Sonata', 'Symphony', 'Booty Bass', 'Primus',
    'Porn Groove', 'Satire', 'Slow Jam', 'Club', 'Tango', 'Samba',
    'Folklore', 'Ballad', 'Power Ballad', 'Rhythmic Soul', 'Freestyle',
    'Duet', 'Punk Rock', 'Drum Solo', 'Acapella', 'Euro-House', 'Dance Hall',
    'Goa', 'Drum & Bass', 'Club-House', 'Hardcore', 'Terror', 'Indie',
    'BritPop', 'Negerpunk', 'Polsk Punk', 'Beat', 'Christian Gangsta Rap',
    'Heavy Metal', 'Black Metal', 'Crossover', 'Contemporary Christian',
    'Christian Rock', 'Merengue', 'Salsa', 'Trash Metal', 'Anime', 'Jpop',
    'Synthpop'  {and probably more to come}
  );

implementation



{$R *.DFM}
var musicfiles : shortstring;

const
  TotalSongsSelected : integer=1;
  songindex : integer=1;
  MCI_SETAUDIO               = $0873;
  MCI_DGV_SETAUDIO_VOLUME    = $4002;
  MCI_DGV_SETAUDIO_ITEM      = $00800000;
  MCI_DGV_SETAUDIO_VALUE     = $01000000;

 type
   MCI_DGV_SETAUDIO_PARMS =
   record
   dwCallback : DWORD;
   dwItem     : DWORd;
   dwValue : DWORD;
   dwOver : DWORD;
   lpstrAlgorithm : PChar;
   lpstrQuality : PChar;
   end;
(*
procedure TForm1.WMDeviceChange (var Msg: TMessage);
const
  CD_IN  = $8000;
  CD_OUT = $8004;
var
  myMsg : String;
begin
   inherited;
   case Msg.wParam of
     CD_IN  : myMsg := 'CD inserted!';
     CD_OUT : myMsg := 'CD removed!';
   end;
   ShowMessage(myMsg);
end;
*)
function IsAudioCD(Drive : char) : boolean;
var
  DrivePath : string;
  MaximumComponentLength : DWORD;
  FileSystemFlags : DWORD;
  VolumeName : string;
  OldErrorMode: UINT;
  DriveType: UINT;
begin
  Result := false;
  DrivePath := Drive + ':\';
  OldErrorMode := SetErrorMode(SEM_FAILCRITICALERRORS);
  DriveType := GetDriveType(Pchar(DrivePath));
  SetErrorMode(OldErrorMode);
  if DriveType <> DRIVE_CDROM then
     exit;
  SetLength(VolumeName, 64);
  GetVolumeInformation(PChar(DrivePath),
                       PChar(VolumeName),
                       Length(VolumeName),
                       nil,
                       MaximumComponentLength,
                       FileSystemFlags,
                       nil,
                       0);
  if lStrCmp(PChar(VolumeName),'Audio CD') = 0 then result := true;
end;

procedure SetMPVolume(MP : TMediaPlayer; Volume : Integer);
{ Volume: 0 - 1000 }
 var p : MCI_DGV_SETAUDIO_PARMS;
begin
  p.dwCallback := 0;
  p.dwItem := MCI_DGV_SETAUDIO_VOLUME;
  p.dwValue:=Volume;
  p.dwOver:=0;
  p.lpstrAlgorithm:= nil;
  p.lpstrQuality:= nil;
  mciSendCommand(MP.DeviceID, MCI_SETAUDIO,
  MCI_DGV_SETAUDIO_VALUE or MCI_DGV_SETAUDIO_ITEM, Cardinal(@p));
end;


procedure FillID3TagInformation(mp3File:string);
var //fMP3: file of Byte;
    ID3 : TID3Rec;
    fmp3: TFileStream;
label  done;
const cc='Unknown !';
begin
  if pos('.MP3',uppercase(mp3file))=0 then goto done;
  fmp3:=TFileStream.Create(mp3File, fmOpenRead);
  try
    fmp3.position:=fmp3.size-128;
    fmp3.Read(ID3,SizeOf(ID3));
  finally
    fmp3.free;
  end;

 { or the non Stream approach - as in ChangeID3Tag procedure
 try
   AssignFile(fMP3, mp3File);
   Reset(fMP3);
   try
     Seek(fMP3, FileSize(fMP3) - 128);
     BlockRead(fMP3, ID3, SizeOf(ID3));
   finally
   end;
 finally
   CloseFile(fMP3);
 end;
 }
 with form1 do
 begin
 if ID3.Tag <> 'TAG' then
 begin
  done:
   edTitle.caption:=cc;
   edArtist.caption:=cc;
   edAlbum.caption:=cc;
   edYear.caption:=cc;
   edGenre.caption:=cc;
   edComment.caption:=cc;
 end else
 begin
   edTitle.caption:=ID3.Title;
   edArtist.caption:=ID3.Artist;
   edAlbum.caption:=ID3.Album;
   edYear.caption:=ID3.Year;
   if ID3.Genre in [0..MaxID3Genre] then
     edGenre.caption:=ID3Genre[ID3.Genre]
   else
     edGenre.caption:=IntToStr(ID3.Genre)+' ? unknown';
    edComment.caption:=ID3.Comment
 end
 end
end;


procedure ChangeID3Tag(NewID3: TID3Rec; mp3FileName: string);
var
  fMP3: file of Byte;
  OldID3 : TID3Rec;
begin
  try
    AssignFile(fMP3, mp3FileName);
    Reset(fMP3);
    try
      Seek(fMP3, FileSize(fMP3) - 128);
      BlockRead(fMP3, OldID3, SizeOf(OldID3));
      if OldID3.Tag = 'TAG' then
        { Replace old tag }
        Seek(fMP3, FileSize(fMP3) - 128)
      else
        { Append tag to file because it doesn't exist }
        Seek(fMP3, FileSize(fMP3));
      BlockWrite(fMP3, NewID3, SizeOf(NewID3));
    finally
    end;
  finally
    CloseFile(fMP3);
  end;
end;

procedure Tform1.ShowCdStatus;
var Trk,Min,Sec : integer;
begin
 with mp3player do
 begin
    Trk:= MCI_TMSF_TRACK(Position);
    Min:= MCI_TMSF_MINUTE(Position);
    Sec:= MCI_TMSF_SECOND(Position);
 end;
 label8.Caption:='Trk '+inttostr(trk)+'  '+inttostr(min)+':'+inttostr(sec)
end;

procedure PlayMediaFile(MediaFileName  : shortstring);
var s : shortstring;  f :textfile;
     a1,a2,a3 :string[2];
     i,j,k,h,m,ss : integer;
begin
 with form1 do
 begin
  s:=ExtractFileDir(paramstr(0));
  if s[length(s)]<>'\' then s:=s+'\';
  s:=s+'RecentPlayList.txt';
  Caption:='mp3 player '+mediafilename;
  mediafilename:=lowercase(mediafilename);
  if RecentPlayList.Items.IndexOf(mediafilename)=-1 then
  begin
    RecentPlayList.Items.Add(mediafilename);
    if fileexists(s) then
    begin assignfile(f,s);
          reset(f); append(f); writeln(f,mediafilename);
          closefile(f)
    end else
    begin assignfile(f,s);
          rewrite(f); writeln(f,mediafilename); closefile(f)
    end
  end;
  mp3player.DeviceType:=dtAutoSelect;
  FillID3TagInformation(mediafilename);
  mp3player.Close;
  mp3player.FileName:=mediafilename;
  if pos('.AVI',uppercase(mediafilename))>0 then
  begin mp3player.Display:=videopanel;
        pagecontrol1.ActivePage:=tabsheet4
  end;
  if pos('.AVI',uppercase(mediafilename))>0 then
  begin mp3player.Display:=videopanel;
        pagecontrol1.ActivePage:=tabsheet4
  end; mp3player.Notify:=true;
  if checkbox1.Checked then songlist.Add(mediafilename);
  mp3player.Open;
  i:=mp3player.Length;
  ProgressBar.MaxValue := mp3player.Length div 10000;
  ProgressBar.Progress:=0;
  mp3player.Play;
  if mp3player.TimeFormat=tfMilliseconds then
  begin j:=i div 1000; k:=j; h:=j div 3600; j:=j-h*3600; m:=j div 60; ss:=j mod 60;
        str(h:2,a1); if a1[1]=' ' then a1[1]:='0';
        str(m:2,a2); if a2[1]=' ' then a2[1]:='0';
        str(ss:2,a3); if a3[1]=' ' then a3[1]:='0';
        label7.caption:='Track Length='+a1+':'+a2+':'+a3+'='+inttostr(k)+' Sec'
  end;
  ProgresTimer.Enabled:=true;
  trackbar1.Max:=i; trackbar1.Position:=0;
 end
end;{PlayMediaFile}

procedure TForm1.ProgresTimerTimer(Sender: TObject);
var j,i,h,m,s,z,l : integer; t : double;  st : shortstring;
    a1,a2,a3 : string[2];
const c : integer=-1;
begin
  if mp3player.DeviceType=dtCdAudio then
  begin ShowCDstatus;
        exit;
  end; l:=mp3player.Length;
  i:=mp3player.Position;
  t:=(i/l); z:=round(t*100);
  ProgressBar.Progress:=round(t*ProgressBar.Maxvalue);
  TrackBar1.Position:=i;
  if mp3player.TimeFormat=tfMilliseconds then
  begin j:=i div 1000; h:=j div 3600;
        j:=j-h*3600; m:=j div 60; s:=j mod 60;
        str(h:2,a1); if a1[1]=' ' then a1[1]:='0';
        str(m:2,a2); if a2[1]=' ' then a2[1]:='0';
        str(s:2,a3); if a3[1]=' ' then a3[1]:='0';
        label8.caption:='['+inttostr(songlist.count)+']'+
        a1+':'+a2+':'+a3+'/'+inttostr(i div 1000);
  end else
  if mp3player.TimeFormat=tfHMS then
  begin {
        str(Ttfhms(i).hr:2,a1); if a1[1]=' ' then a1[1]:='0';
        str(Ttfhms(i).mi:2,a2); if a2[1]=' ' then a2[1]:='0';
        str(Ttfhms(i).se:2,a3); if a3[1]=' ' then a3[1]:='0';
        }
        label8.caption:=inttostr(i)
  end;
  if ((flag1=1)and(c<>z))or(Internalflag2=true) then
  begin st:='['+inttostr(songlist.count)+']'+inttostr(z)+'%';
        application.Title:=st;  gbTrayIcon1.Hint:='MP3 Player'+#13#10+st;
  c:=z
  end;
  if l=i then
  begin
   progrestimer.Enabled:=false;
   if (songlist.count>0) then
   begin
        mp3player.Close;
        Playmediafile(songlist.strings[0]);
        if checkbox1.Checked=false then
        songlist.Delete(0)
   end else
   mp3player.Close
  end;
end;

procedure TForm1.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
 if key in['0'..'9',^C,^V,#8,#13] then else key:=#0;
 if key=#13 then GotopositionClick(sender)
end;

procedure TForm1.TrackBar1Change(Sender: TObject);
begin
 if progrestimer.Enabled=false then exit;
 mp3player.Position:=trackbar1.Position;
 mp3player.Play
end;

procedure TForm1.DirectoryListBoxChange(Sender: TObject);
begin
 DirectoryListBox.FileList:=Filelistbox
end;

procedure TForm1.FormIsMinimized(sender : Tobject);
begin
 flag1:=1
end;

procedure TForm1.FormIsRestored(sender : Tobject);
begin
 flag1:=0;
 application.Title:='MP3 player'
end;

procedure TForm1.FormCreate(Sender: TObject);
var s,t,r : shortstring;
begin randomize;
 Application.OnMinimize:=FormisMinimized;
 Application.OnRestore:=FormIsRestored;
 r:=uppercase(paramstr(1));
 (*
 if r<>'' then
 begin directorylistbox.Drive:=r[1];
       directorylistbox.Directory:=r+'\'
 end;
 *)
 s:=ExtractFileDir(paramstr(0));
 if s[length(s)]<>'\' then s:=s+'\'; t:=s+'MusicDiaryNotes.TXT';
 s:=s+'RecentPlayList.TXT';
 musicfiles:=s;
 if fileExists(s) then
 RecentPlayList.Items.LoadFromFile(s);
 pagecontrol1.ActivePage:=tabsheet2;
 songlist:=tstringlist.Create;
 pagecontrol1.ActivePage:=tabsheet2;
 if fileexists(t) then
 memo1.Lines.LoadFromFile(t)
end;


procedure TForm1.RecentPlayListOmid(Sender: TObject);
var mp3file : shortstring;
begin
  if RecentPlayList.Items.Count=0 then exit;
  if recentplaylist.itemindex=-1 then exit;
  mp3file:=recentplaylist.Items[recentplaylist.itemindex];
  PlayMediafile(mp3file);
end;

procedure TForm1.GotoPositionClick(Sender: TObject);
var i : integer;
begin
 if mp3player.DeviceType=dtCdAudio then exit;
 if integer(mp3player.Mode)>10 then exit;
 //if ProgresTimer.Enabled=false then exit;
 i:=strtoint(edit1.text);
 i:=i*1000;
 if i<mp3player.Length then
 begin mp3player.Position:=i;
       mp3player.play
 end else showmessage('Invalid range')
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
var mp3file,t : shortstring; i :integer;
begin
  if bitbtn1.Caption='Play' then
  begin
  songindex:=1;
  if indirect=true then
  begin mp3file:=paramstr(1);
        Playmediafile(mp3file);
        exit
  end;
  if pagecontrol1.ActivePage=tabsheet3 then
  begin bitbtn1.Caption:='Stop';
        RecentPlayListOmid(Sender);
        exit
  end;
  if filelistbox.Items.Count=0 then exit;
  if filelistbox.ItemIndex=-1 then
  begin showmessage('No file selected !');
        exit
  end;
  if memo2.Lines.Count=0 then songlist.Clear;
  t:=DirectoryListBox.Directory;
  if t[length(t)]<>'\' then t:=t+'\';
  if memo2.Lines.Count=0 then
  for i:=0 to filelistbox.Items.Count-1 do
  if filelistbox.Selected[i] then songlist.Add(t+filelistbox.items.Strings[i]);
  mp3file:=songlist.Strings[0];
  if checkbox1.Checked=false
  then begin songlist.Delete(0);
       end;
  Playmediafile(mp3file);
  bitbtn1.Caption:='Stop'
  end
  else
  begin ProgresTimer.Enabled:=false;
        progressbar.Progress:=0; trackbar1.Position:=0;
        mp3player.Close; bitbtn1.Caption:='Play'
  end
end;

procedure TForm1.TabSheet2Enter(Sender: TObject);
begin
 Bitbtn1.Visible:=false
end;

procedure TForm1.RecentPlayListKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  var i : integer; temp : tstringlist;
begin
 if key=46 then
 begin temp:=tstringlist.Create;
  for i:=0 to Recentplaylist.Items.Count-1 do
  if Recentplaylist.Selected[i]=false
  then temp.Add(recentplaylist.items.strings[i]);
  recentplaylist.Items.Assign(temp);
  RecentPlayList.Items.SaveToFile(musicfiles);
  temp.Free
 end;
 {
 if key=46 then // Delete key
 begin i:=RecentPlayList.ItemIndex;
       if i<0 then exit;
       RecentPlayList.Items.Delete(i);

 end
 }
end;

procedure TForm1.TabSheet1Enter(Sender: TObject);
begin
 Bitbtn1.Visible:=true
end;

procedure TForm1.FormShow(Sender: TObject);
var s,t,u : string;
begin
 if paramstr(1)<>'' then
 begin
   t:=ExtractFileDrive(paramstr(1));
   u:=ExtractFileName(paramstr(1));
   s:=ExtractFilePath(paramstr(1));
   setlength(s,length(s)-1);
   if DirectoryExists(s) then
   DirectoryListBox.Directory:=s;
   if fileexists(paramstr(1)) then
   begin indirect:=true;
         pagecontrol1.ActivePage:=tabsheet1;
         filelistbox.ItemIndex:=filelistbox.Items.IndexOf(u);
         Bitbtn1click(sender)
   end
 end
end;

procedure TForm1.TrackBar2Change(Sender: TObject);
begin
 SetMPVolume(Mp3player,TrackBar2.Position)
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
 if internalflag1 then
 begin canclose:=true;
       exit
 end;
 //if Messagedlg('mp3 player EXIT now?',mtconfirmation,[mbyes,mbcancel],0)=mryes
 //then canclose:=true else canclose:=false
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
 filelistbox.Mask:=combobox1.Items[combobox1.itemindex]
end;

procedure TForm1.ComboBox1KeyPress(Sender: TObject; var Key: Char);
begin
key:=#0; combobox1.SelLength:=0;
//combobox1.Focused:=false
end;

procedure TForm1.Sound1Click(Sender: TObject);
begin
WinExec('rundll32.exe shell32.dll,Control_RunDLL access.cpl,,2',SW_SHOWNORMAL);

end;

procedure TForm1.PlayCDClick(Sender: TObject);
begin
 //mp3player.Stop;
 //mp3player.Close;
 mp3player.DeviceType:=dtCDAudio;
 mp3player.Open;
 mp3player.Play;
 ProgresTimer.Enabled:=true
end;

procedure TForm1.Exit1Click(Sender: TObject);
begin
close
end;

function GetWinDir: ShortString;
var  dir: array [0..80] of char;
begin
 GetWindowsDirectory(dir,80);
 result:=StrPas(dir)+'\';
end;

procedure TForm1.Volume1Click(Sender: TObject);
var s : shortstring;
begin s:=GetWinDir+'sndvol32.exe';
shellexecute(handle,'open',pchar(string(s)),nil,nil,sw_normal)
end;


procedure TForm1.Minimize1Click(Sender: TObject);
begin
//application.Minimize
gbtrayicon1.PutInTray(true);
internalflag2:=true
end;

procedure TForm1.ClearList1Click(Sender: TObject);
var s : tstringlist;
begin songlist.Clear;
 s:=tstringlist.Create; s.Assign(filelistbox.items);
 filelistbox.Clear;
 filelistbox.Items.Assign(s);
 s.free
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 songlist.Free;
end;

procedure TForm1.mp3playerNotify(Sender: TObject);
var i : integer;
begin
 if (mp3player.mode=mpstopped)and(mp3player.Position=mp3player.Length) then
 begin
   progrestimer.Enabled:=false;
   Trackbar1.Position:=0;
   if songlist.count>0 then
   begin i:=memo2.Lines.Count-songlist.count;
         Playmediafile(songlist.strings[0]);
         songlist.Delete(0);
         memo2.Lines[i]:='*'+memo2.Lines[i];
   end else application.Restore;
 end;
 with mp3player do
 case
  mode of
    mpPlaying :
       begin spdbtn1.Caption:='Pause' ;
             statictext2.Caption:='Playing'
       end;
    mpPaused :
      begin spdbtn1.Caption:='Resume';
            statictext2.Caption:='Paused'
      end;
    mpNotReady: statictext2.Caption:='Not Ready';
    mpStopped: statictext2.Caption:='Stopped';
    mpRecording: statictext2.Caption:='Recording';
    mpSeeking: statictext2.Caption:='Seeking';
    mpOpen: statictext2.Caption:='Dev Open'
   else statictext2.Caption:='Unknown state';
  end;
 mp3player.Notify:=true
end;

procedure TForm1.About1Click(Sender: TObject);
begin
 showmessage('Free MP3 and media file player for Windows')
end;

procedure TForm1.spdbtn1Click(Sender: TObject);
begin
// try mp3player.Pause; except exit end;
 try
 with spdbtn1 do
 if Caption='Pause' then
 begin Caption:='Resume';
       TrayPauseRestore.Caption:='Resume';
       mp3player.pause
 end
 else
 begin caption:='Pause';
       TrayPauseRestore.Caption:='Pause';
       mp3player.Resume
 end
 except

 end
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
var s : shortstring;
begin
 s:=ExtractFileDir(paramstr(0));
 if s[length(s)]<>'\' then s:=s+'\';
 s:=s+'MusicDiaryNotes.TXT';
 try
 memo1.Lines.SaveToFile(s)
 finally
 end;
end;

procedure TForm1.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
  if key in['0'..'9',#3,#8,^V] then else key:=#0;
end;

procedure TForm1.BitBtn3Click(Sender: TObject);
var i,j,k : integer;
begin
 if mp3player.DeviceType=dtCdAudio then exit;
 //if ProgresTimer.Enabled=false then exit;
 i:=mp3player.Length ; j:=mp3player.Position;
 k:=strtoint(edit2.Text)*1000;
 if j+k<i then
 begin mp3player.Position:=j+k;
       mp3player.play
 end
end;

procedure TForm1.BitBtn4Click(Sender: TObject);
var i,j,k : integer;
begin
 if mp3player.DeviceType=dtCdAudio then exit;
 if ProgresTimer.Enabled=false then exit;
 i:=mp3player.Length; j:=mp3player.Position;
 k:=strtoint(edit2.Text)*1000;
 if k<j then
 begin mp3player.Position:=j-k;
       mp3player.play
 end
end;

procedure TForm1.ShowmainAppClick(Sender: TObject);
begin
 gbtrayicon1.RemoveFromTray; internalflag2:=false;
 Application.Restore; form1.Show;
end;

procedure TForm1.TrayPauseRestoreClick(Sender: TObject);
begin
 spdbtn1Click(sender)
end;

procedure TForm1.Exit2Click(Sender: TObject);
begin internalflag1:=true; close

end;

procedure TForm1.btnRandomClick(Sender: TObject);
var i : integer;
begin
  if mp3player.DeviceType=dtCdAudio then exit;
  if integer(mp3player.Mode)>10 then exit;
  i:=random(mp3player.length)+1;
  mp3player.Position:=i;
  mp3player.play
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
 edit1.Text:=inttostr(mp3player.Position div 1000)
end;

procedure TForm1.Button2Click(Sender: TObject);
var i,j,k : integer; st : tstringlist;  s : string[255];
begin randomize;
 st:=tstringlist.Create; st.Assign(FileListBox.Items);
 j:=st.Count-1;
 for i:=0 to j-1 do
 begin s:=st.Strings[i]; k:=random(j);
       st.Strings[i]:=st.Strings[k]; st.Strings[k]:=s
 end;
 memo2.Lines.Assign(st);
 songlist.Assign(st);
 st.Free
end;


procedure TForm1.mnuSaveThisListClick(Sender: TObject);
var s : string;
begin
 s:=uppercase(InputBox('File name txt ','File name txt',''));
 if pos('.TXT',s)=0 then s:=s+'.txt';
 memo2.lines.SaveToFile(s)
end;

procedure TForm1.mnuLoadFromListClick(Sender: TObject);
var s : string;
begin
   s:=uppercase(InputBox('File name txt ','File name txt',''));
   if pos('.TXT',s)=0 then s:=s+'.txt';
   songlist.LoadFromFile(s);
   memo2.Lines.Assign(songlist)
end;

end.


