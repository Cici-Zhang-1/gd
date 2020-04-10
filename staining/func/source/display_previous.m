function display_previous(img, n)
    global showHistory
    global currentHistory
    
    if currentHistory < 2
        return
    end
    currentHistory = currentHistory - 1;
    tmp = showHistory(:, :, currentHistory);
    toshow = img.CData;
    toshow(:, :, n) = tmp;
    display_refresh(img, toshow);
    return
end