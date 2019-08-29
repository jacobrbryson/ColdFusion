component extends="Base.HeartBeat"{
    public HeartBeat function Save(User User){
        HeartBeat = GetObject(['UserID'],[User.ID]);
        HeartBeat.User.setID(User.ID);
        HeartBeat.setTick(now());
        return HeartBeat.ID eq 0 ? Add(HeartBeat) : Update(HeartBeat);
    }
}