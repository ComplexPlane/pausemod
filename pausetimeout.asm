#function $hook 0x00004fc4 % 0x802750c4
b $handlePauseState

#function $mainLoopRelSpace 0x0021b120 % 0x8048b220, size 496
0x00000000 % Our timer for the game being unpaused

#function $handlePauseState after $mainLoopRelSpace

% If we're not in the play submode, don't bother with any of this
lis r5, 0x8054
ori r5, r5, 0xdc34
lwz r5, 0x0(r5)
cmpwi r5, 51
bne .ignore
b .doPauseChecking

.ignore
% Store 0 in the counter
lis r5, 0x8048
ori r5, r5, 0xb220
li r6, 0
stw r6, 0x0(r5)
b .end

.doPauseChecking
% Check whether the game is paused
lis r5, 0x8054
ori r5, r5, 0xdcb0
lwz r5, 0x0(r5)
rlwinm r5, r5, 0, 31, 31
cmpwi r5, 0
beq .paused

.unpaused
% Tick down the counter until it's zero
lis r5, 0x8048
ori r5, r5, 0xb220
lwz r6, 0x0(r5)
cmpwi r6, 0
beq .end % OK to pause again

% Subtract 1 from the counter and don't allow a pause
subi r6, r6, 1
stw r6, 0x0(r5)
li r0, 0 % Don't count this as a pause
b .end

.paused
% Store 60 in the counter
lis r5, 0x8048
ori r5, r5, 0xb220
li r6, 60
stw r6, 0x0(r5)

.end
% Load address of instruction after hook point
lis r5, 0x8027
ori r5, r5, 0x50c8
mtlr r5

cmpwi r0, 0 % Original overwritten instruction
blr
