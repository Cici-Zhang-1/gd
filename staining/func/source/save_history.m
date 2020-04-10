% how to save history
% saveType 1: next
%          2: previous
function save_history (img, n)
    global showHistory
    global currentHistory
%     global maxHistory
%     global currentHistory
%     global toshow
%     if 1 == saveType
%         currentHistory = currentHistory + 1;
%         if currentHistory > 10
%             showHistory = circshift(showHistory,-1, 4);
%             currentHistory = 10;
%         end
%         maxHistory = currentHistory;
%         showHistory(:, :, :, currentHistory) = toshow;
%     else
%     end
    currentHistory = currentHistory + 1;
    showHistory(:, :, currentHistory) = img(:, :, n);
    showHistory = showHistory(:, :, 1:currentHistory);
    return;
end