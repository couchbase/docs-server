function getBusinessDays(startDate, endDate) {
    let count = 0;
    const curDate = new Date(new Date(startDate).getTime());
    while (curDate <= new Date(endDate)) {
        const dayOfWeek = curDate.getDay();
        if(dayOfWeek !== 0 && dayOfWeek !== 6)
            count++;
        curDate.setDate(curDate.getDate() + 1);
    }
    return count;    // <.>
}
