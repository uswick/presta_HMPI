	.section .text
.LNDBG_TX:
# mark_description "Intel(R) C Intel(R) 64 Compiler XE for applications running on Intel(R) MIC Architecture, Version 13.1.0.146";
# mark_description " Beta Build 20130121";
# mark_description "-I/home1/02636/uswickra/Sync/HMPI/hmpi-svn -I/opt/apps/intel13/impi/4.1.0.030/mic/include -mmic -g -openmp -";
# mark_description "D__USE_GNU -D_GNU_SOURCE -S -c";
	.file "transfer.c"
	.text
..TXTST0:
L__routine_start_do_strasnfer_0:
# -- Begin  do_strasnfer
# mark_begin;
# Threads 4
        .align    2,0x90
	.globl do_strasnfer
do_strasnfer:
# parameter 1(req): %rdi
..B1.1:                         # Preds ..B1.0
..___tag_value_do_strasnfer.2:                                  #
..LN0:
  .file   1 "transfer.c"
   .loc    1  8  is_stmt 1
        pushq     %rbp                                          #8.35
..___tag_value_do_strasnfer.4:                                  #
..LN1:
        movq      %rsp, %rbp                                    #8.35
..___tag_value_do_strasnfer.5:                                  #
..LN2:
        subq      $544, %rsp                                    #8.35
..LN3:
        movq      %rbx, -16(%rbp)                               #8.35
..LN4:
        movq      %rdi, -528(%rbp)                              #8.35
..LN5:
   .loc    1  10  is_stmt 1
        movq      -528(%rbp), %rax                              #10.31
..LN6:
        movq      24(%rax), %rax                                #10.31
..LN7:
        movq      %rax, -520(%rbp)                              #10.29
..LN8:
   .loc    1  11  is_stmt 1
        movq      -528(%rbp), %rax                              #11.19
..LN9:
        movq      32(%rax), %rax                                #11.19
..LN10:
        movq      %rax, -512(%rbp)                              #11.17
..LN11:
   .loc    1  12  is_stmt 1
        movq      -528(%rbp), %rax                              #12.19
..LN12:
        movq      40(%rax), %rax                                #12.19
..LN13:
        movq      %rax, -504(%rbp)                              #12.17
..LN14:
   .loc    1  14  is_stmt 1
        movq      -528(%rbp), %rax                              #14.5
..LN15:
        movl      $0, 48(%rax)                                  #14.5
..LN16:
   .loc    1  15  is_stmt 1
        movl      $0, -540(%rbp)                                #15.11
..LN17:
   .loc    1  16  is_stmt 1
        movl      $1, %eax                                      #16.7
..LN18:
        addl      scount(%rip), %eax                            #16.7
..LN19:
        movl      %eax, scount(%rip)                            #16.7
..LN20:
   .loc    1  17  is_stmt 1
        movl      $0, -540(%rbp)                                #17.9
..LN21:
        movl      -540(%rbp), %eax                              #17.16
..LN22:
        cmpl      $60, %eax                                     #17.20
..LN23:
        jl        ..B1.3        # Prob 50%                      #17.20
..LN24:
        jmp       ..B1.4        # Prob 100%                     #17.20
..___tag_value_do_strasnfer.8:                                  #
..LN25:
                                # LOE rbp rsp r12 r13 r14 r15 rip
..B1.2:                         # Preds ..B1.11
..LN26:
        movl      $1, %eax                                      #17.28
..LN27:
        addl      -540(%rbp), %eax                              #17.28
..LN28:
        movl      %eax, -540(%rbp)                              #17.28
..LN29:
        movl      -540(%rbp), %eax                              #17.16
..LN30:
        cmpl      $60, %eax                                     #17.20
..LN31:
        jge       ..B1.4        # Prob 50%                      #17.20
..LN32:
                                # LOE rbp rsp r12 r13 r14 r15 rip
..B1.3:                         # Preds ..B1.2 ..B1.1
..LN33:
   .loc    1  18  is_stmt 1
        movl      $0, %eax                                      #18.11
..LN34:
        negq      %rax                                          #18.11
..LN35:
        lea       -496(%rbp), %rdx                              #18.11
..LN36:
        movl      $8, %ecx                                      #18.11
..LN37:
        movl      -540(%rbp), %ebx                              #18.11
..LN38:
        movslq    %ebx, %rbx                                    #18.11
..LN39:
        imulq     %rcx, %rbx                                    #18.11
..LN40:
        addq      %rbx, %rdx                                    #18.11
..LN41:
        addq      %rdx, %rax                                    #18.11
..LN42:
        movl      $0, %edx                                      #18.11
..LN43:
        movl      $pipeline_transfer, %ecx                      #18.11
..LN44:
        movq      -528(%rbp), %rbx                              #18.11
..LN45:
        movq      %rax, %rdi                                    #18.11
..LN46:
        movq      %rdx, %rsi                                    #18.11
..LN47:
        movq      %rcx, %rdx                                    #18.11
..LN48:
        movq      %rbx, %rcx                                    #18.11
..___tag_value_do_strasnfer.9:                                  #18.11
..LN49:
        call      pthread_create                                #18.11
..___tag_value_do_strasnfer.10:                                 #
..LN50:
                                # LOE rbp rsp r12 r13 r14 r15 rip eax
..B1.11:                        # Preds ..B1.3
..LN51:
        movl      %eax, -536(%rbp)                              #18.11
..LN52:
        jmp       ..B1.2        # Prob 100%                     #18.11
..LN53:
                                # LOE rbp rsp r12 r13 r14 r15 rip
..B1.4:                         # Preds ..B1.2 ..B1.1
..LN54:
   .loc    1  26  is_stmt 1
        movq      -512(%rbp), %rax                              #26.12
..LN55:
        movl      $1, %edx                                      #26.12
..LN56:
        movl      $0, %ecx                                      #26.12
..LN57:
        movq      %rax, %rdi                                    #26.12
..LN58:
        movl      %edx, %eax                                    #26.12
..LN59:
        lock      
        cmpxchg   %ecx, (%rdi)                                  #26.12
..LN60:
        sete      %al                                           #26.12
..LN61:
                                # LOE rbp rsp r12 r13 r14 r15 rip eax
..B1.12:                        # Preds ..B1.4
..LN62:
        movb      %al, -544(%rbp)                               #26.12
..LN63:
                                # LOE rbp rsp r12 r13 r14 r15 rip
..B1.5:                         # Preds ..B1.12
..LN64:
        movb      -544(%rbp), %al                               #26.12
..LN65:
        andl      $255, %eax                                    #26.12
..LN66:
        movzbl    %al, %eax                                     #26.12
..LN67:
        testl     %eax, %eax                                    #26.12
..LN68:
        jne       ..B1.8        # Prob 50%                      #26.12
..LN69:
                                # LOE rbp rsp r12 r13 r14 r15 rip
..B1.6:                         # Preds ..B1.7 ..B1.5
..LN70:
        movq      -512(%rbp), %rax                              #26.12
..LN71:
        movl      $1, %edx                                      #26.12
..LN72:
        movl      $0, %ecx                                      #26.12
..LN73:
        movq      %rax, %rdi                                    #26.12
..LN74:
        movl      %edx, %eax                                    #26.12
..LN75:
        lock      
        cmpxchg   %ecx, (%rdi)                                  #26.12
..LN76:
        sete      %al                                           #26.12
..LN77:
                                # LOE rbp rsp r12 r13 r14 r15 rip eax
..B1.13:                        # Preds ..B1.6
..LN78:
        movb      %al, -544(%rbp)                               #26.12
..LN79:
                                # LOE rbp rsp r12 r13 r14 r15 rip
..B1.7:                         # Preds ..B1.13
..LN80:
        movb      -544(%rbp), %al                               #26.12
..LN81:
        andl      $255, %eax                                    #26.12
..LN82:
        movzbl    %al, %eax                                     #26.12
..LN83:
        testl     %eax, %eax                                    #26.12
..LN84:
        je        ..B1.6        # Prob 50%                      #26.12
..LN85:
                                # LOE rbp rsp r12 r13 r14 r15 rip
..B1.8:                         # Preds ..B1.7 ..B1.5
..LN86:
   .loc    1  32  is_stmt 1
        movq      -16(%rbp), %rbx                               #32.1
..___tag_value_do_strasnfer.11:                                 #
..LN87:
        leave                                                   #32.1
..___tag_value_do_strasnfer.13:                                 #
..LN88:
        ret                                                     #32.1
        .align    2,0x90
..___tag_value_do_strasnfer.16:                                 #
..LN89:
                                # LOE
..LN90:
# mark_end;
	.type	do_strasnfer,@function
	.size	do_strasnfer,.-do_strasnfer
..LNdo_strasnfer.91:
.LNdo_strasnfer:
	.data
  .file   2 "transfer.h"
  .file   3 "/usr/linux-k1om-4.7/linux-k1om/usr/include/stdint.h"
  .file   4 "/usr/linux-k1om-4.7/linux-k1om/usr/include/bits/pthreadtypes.h"
# -- End  do_strasnfer
	.text
L__routine_start_do_rtrasnfer_1:
# -- Begin  do_rtrasnfer
# mark_begin;
# Threads 4
        .align    2,0x90
	.globl do_rtrasnfer
do_rtrasnfer:
# parameter 1(req): %rdi
..B2.1:                         # Preds ..B2.0
..___tag_value_do_rtrasnfer.18:                                 #
..LN92:
   .loc    1  34  is_stmt 1
        pushq     %rbp                                          #34.35
..___tag_value_do_rtrasnfer.20:                                 #
..LN93:
        movq      %rsp, %rbp                                    #34.35
..___tag_value_do_rtrasnfer.21:                                 #
..LN94:
        subq      $48, %rsp                                     #34.35
..LN95:
        movq      %rdi, -32(%rbp)                               #34.35
..LN96:
   .loc    1  36  is_stmt 1
        movq      -32(%rbp), %rax                               #36.31
..LN97:
        movq      24(%rax), %rax                                #36.31
..LN98:
        movq      %rax, -24(%rbp)                               #36.29
..LN99:
   .loc    1  37  is_stmt 1
        movq      -32(%rbp), %rax                               #37.19
..LN100:
        movq      32(%rax), %rax                                #37.19
..LN101:
        movq      %rax, -16(%rbp)                               #37.17
..LN102:
   .loc    1  38  is_stmt 1
        movq      -32(%rbp), %rax                               #38.19
..LN103:
        movq      40(%rax), %rax                                #38.19
..LN104:
        movq      %rax, -8(%rbp)                                #38.17
..LN105:
   .loc    1  40  is_stmt 1
        movl      $0, -44(%rbp)                                 #40.11
..LN106:
   .loc    1  50  is_stmt 1
        movq      -8(%rbp), %rax                                #50.12
..LN107:
        movl      $60, %edx                                     #50.12
..LN108:
        movl      $0, %ecx                                      #50.12
..LN109:
        movq      %rax, %rdi                                    #50.12
..LN110:
        movl      %edx, %eax                                    #50.12
..LN111:
        lock      
        cmpxchg   %ecx, (%rdi)                                  #50.12
..LN112:
        sete      %al                                           #50.12
..LN113:
                                # LOE rbx rbp rsp r12 r13 r14 r15 rip eax
..B2.8:                         # Preds ..B2.1
..LN114:
        movb      %al, -48(%rbp)                                #50.12
..LN115:
                                # LOE rbx rbp rsp r12 r13 r14 r15 rip
..B2.2:                         # Preds ..B2.8
..LN116:
        movb      -48(%rbp), %al                                #50.12
..LN117:
        andl      $255, %eax                                    #50.12
..LN118:
        movzbl    %al, %eax                                     #50.12
..LN119:
        testl     %eax, %eax                                    #50.12
..LN120:
        jne       ..B2.5        # Prob 50%                      #50.12
..LN121:
                                # LOE rbx rbp rsp r12 r13 r14 r15 rip
..B2.3:                         # Preds ..B2.4 ..B2.2
..LN122:
        movq      -8(%rbp), %rax                                #50.12
..LN123:
        movl      $60, %edx                                     #50.12
..LN124:
        movl      $0, %ecx                                      #50.12
..LN125:
        movq      %rax, %rdi                                    #50.12
..LN126:
        movl      %edx, %eax                                    #50.12
..LN127:
        lock      
        cmpxchg   %ecx, (%rdi)                                  #50.12
..LN128:
        sete      %al                                           #50.12
..LN129:
                                # LOE rbx rbp rsp r12 r13 r14 r15 rip eax
..B2.9:                         # Preds ..B2.3
..LN130:
        movb      %al, -48(%rbp)                                #50.12
..LN131:
                                # LOE rbx rbp rsp r12 r13 r14 r15 rip
..B2.4:                         # Preds ..B2.9
..LN132:
        movb      -48(%rbp), %al                                #50.12
..LN133:
        andl      $255, %eax                                    #50.12
..LN134:
        movzbl    %al, %eax                                     #50.12
..LN135:
        testl     %eax, %eax                                    #50.12
..LN136:
        je        ..B2.3        # Prob 50%                      #50.12
..LN137:
                                # LOE rbx rbp rsp r12 r13 r14 r15 rip
..B2.5:                         # Preds ..B2.4 ..B2.2
..LN138:
   .loc    1  52  is_stmt 1
        movl      $0, count(%rip)                               #52.5
..LN139:
   .loc    1  53  is_stmt 1
        movq      -32(%rbp), %rax                               #53.5
..LN140:
        movl      $0, 48(%rax)                                  #53.5
..LN141:
   .loc    1  54  is_stmt 1
        movl      $0, -40(%rbp)                                 #54.6
..LN142:
        movq      -24(%rbp), %rax                               #54.6
..LN143:
        movl      -40(%rbp), %edx                               #54.6
..LN144:
        movl      %edx, (%rax)                                  #54.6
..LN145:
   .loc    1  55  is_stmt 1
        movq      -16(%rbp), %rax                               #55.6
..LN146:
        movl      $1, (%rax)                                    #55.6
..LN147:
   .loc    1  58  is_stmt 1
        leave                                                   #58.1
..___tag_value_do_rtrasnfer.25:                                 #
..LN148:
        ret                                                     #58.1
        .align    2,0x90
..___tag_value_do_rtrasnfer.28:                                 #
..LN149:
                                # LOE
..LN150:
# mark_end;
	.type	do_rtrasnfer,@function
	.size	do_rtrasnfer,.-do_rtrasnfer
..LNdo_rtrasnfer.151:
.LNdo_rtrasnfer:
	.data
# -- End  do_rtrasnfer
	.text
L__routine_start_pipeline_transfer_2:
# -- Begin  pipeline_transfer
# mark_begin;
# Threads 4
        .align    2,0x90
	.globl pipeline_transfer
pipeline_transfer:
# parameter 1(r): %rdi
..B3.1:                         # Preds ..B3.0
..___tag_value_pipeline_transfer.30:                            #
..LN152:
   .loc    1  60  is_stmt 1
        pushq     %rbp                                          #60.32
..___tag_value_pipeline_transfer.32:                            #
..LN153:
        movq      %rsp, %rbp                                    #60.32
..___tag_value_pipeline_transfer.33:                            #
..LN154:
        subq      $80, %rsp                                     #60.32
..LN155:
        movq      %rdi, -48(%rbp)                               #60.32
..LN156:
   .loc    1  61  is_stmt 1
        movq      -48(%rbp), %rax                               #61.37
..LN157:
        movq      %rax, -40(%rbp)                               #61.21
..LN158:
   .loc    1  63  is_stmt 1
        movq      -40(%rbp), %rax                               #63.21
..LN159:
        lea       48(%rax), %rax                                #63.21
..LN160:
        movl      $1, %edx                                      #63.21
..LN161:
        movq      %rax, %rdi                                    #63.21
..LN162:
        movl      %edx, %ecx                                    #63.21
..LN163:
        lock      
        xaddl     %ecx, (%rdi)                                  #63.21
..LN164:
                                # LOE rbx rbp rsp r12 r13 r14 r15 rip ecx
..B3.12:                        # Preds ..B3.1
..LN165:
        movl      %ecx, -80(%rbp)                               #63.21
..LN166:
                                # LOE rbx rbp rsp r12 r13 r14 r15 rip
..B3.2:                         # Preds ..B3.12
..LN167:
        movl      -80(%rbp), %eax                               #63.21
..LN168:
        movl      %eax, -76(%rbp)                               #63.19
..LN169:
   .loc    1  64  is_stmt 1
        movl      -76(%rbp), %eax                               #64.5
..LN170:
        movl      %eax, %edi                                    #64.5
..___tag_value_pipeline_transfer.36:                            #64.5
..LN171:
        call      init_affinity                                 #64.5
..___tag_value_pipeline_transfer.37:                            #
..LN172:
                                # LOE rbx rbp rsp r12 r13 r14 r15 rip
..B3.3:                         # Preds ..B3.2
..LN173:
   .loc    1  65  is_stmt 1
        movq      -40(%rbp), %rax                               #65.31
..LN174:
        movq      24(%rax), %rax                                #65.31
..LN175:
        movq      %rax, -32(%rbp)                               #65.29
..LN176:
   .loc    1  66  is_stmt 1
        movq      -40(%rbp), %rax                               #66.19
..LN177:
        movl      16(%rax), %eax                                #66.19
..LN178:
        movl      %eax, -72(%rbp)                               #66.17
..LN179:
   .loc    1  67  is_stmt 1
        movq      -40(%rbp), %rax                               #67.22
..LN180:
        movq      (%rax), %rax                                  #67.22
..LN181:
        movq      %rax, -24(%rbp)                               #67.20
..LN182:
   .loc    1  68  is_stmt 1
        movq      -40(%rbp), %rax                               #68.22
..LN183:
        movq      8(%rax), %rax                                 #68.22
..LN184:
        movq      %rax, -16(%rbp)                               #68.20
..LN185:
   .loc    1  69  is_stmt 1
        movl      $0, -68(%rbp)                                 #69.16
..LN186:
   .loc    1  71  is_stmt 1
        movl      $0, %eax                                      #71.5
..LN187:
        cmpl      $1, %eax                                      #71.5
..LN188:
        jne       ..B3.5        # Prob 0%                       #71.5
..LN189:
        jmp       ..B3.8        # Prob 100%                     #71.5
..LN190:
                                # LOE rbx rbp rsp r12 r13 r14 r15 rip
..B3.4:                         # Preds ..B3.14
..LN191:
        movl      $0, %eax                                      #71.5
..LN192:
        cmpl      $1, %eax                                      #71.5
..LN193:
        je        ..B3.8        # Prob 100%                     #71.5
..LN194:
                                # LOE rbx rbp rsp r12 r13 r14 r15 rip
..B3.5:                         # Preds ..B3.4 ..B3.3
..LN195:
   .loc    1  72  is_stmt 1
        movq      -32(%rbp), %rax                               #72.18
..LN196:
        movl      $12288, %edx                                  #72.18
..LN197:
        movq      %rax, %rdi                                    #72.18
..LN198:
        movl      %edx, %ecx                                    #72.18
..LN199:
        lock      
        xaddl     %ecx, (%rdi)                                  #72.18
..LN200:
                                # LOE rbx rbp rsp r12 r13 r14 r15 rip ecx
..B3.13:                        # Preds ..B3.5
..LN201:
        movl      %ecx, -64(%rbp)                               #72.18
..LN202:
                                # LOE rbx rbp rsp r12 r13 r14 r15 rip
..B3.6:                         # Preds ..B3.13
..LN203:
        movl      -64(%rbp), %eax                               #72.18
..LN204:
        movl      %eax, -68(%rbp)                               #72.9
..LN205:
   .loc    1  73  is_stmt 1
        movl      -68(%rbp), %eax                               #73.18
..LN206:
        movl      -72(%rbp), %edx                               #73.28
..LN207:
        cmpl      %edx, %eax                                    #73.28
..LN208:
        jge       ..B3.8        # Prob 50%                      #73.28
..LN209:
                                # LOE rbx rbp rsp r12 r13 r14 r15 rip
..B3.7:                         # Preds ..B3.6
..LN210:
   .loc    1  74  is_stmt 1
        movl      -68(%rbp), %eax                               #74.35
..LN211:
        negl      %eax                                          #74.35
..LN212:
        addl      -72(%rbp), %eax                               #74.35
..LN213:
        movl      %eax, -56(%rbp)                               #74.18
..LN214:
   .loc    1  76  is_stmt 1
        movl      -56(%rbp), %eax                               #76.37
..LN215:
        cmpl      $12288, %eax                                  #76.25
..LN216:
        jl        ..L38         # Prob 50%                      #76.25
..LN217:
        movl      $12288, %eax                                  #76.25
..L38:                                                          #
..LN218:
        movl      %eax, -52(%rbp)                               #76.25
..LN219:
   .loc    1  75  is_stmt 1
        movl      -68(%rbp), %eax                               #75.9
..LN220:
        movslq    %eax, %rax                                    #75.9
..LN221:
        addq      -16(%rbp), %rax                               #75.9
..LN222:
        movl      -68(%rbp), %edx                               #75.9
..LN223:
        movslq    %edx, %rdx                                    #75.9
..LN224:
        addq      -24(%rbp), %rdx                               #75.9
..LN225:
        movl      -52(%rbp), %ecx                               #75.9
..LN226:
        movslq    %ecx, %rcx                                    #75.9
..LN227:
        movq      %rax, %rdi                                    #75.9
..LN228:
        movq      %rdx, %rsi                                    #75.9
..LN229:
        movq      %rcx, %rdx                                    #75.9
..___tag_value_pipeline_transfer.39:                            #75.9
..LN230:
        call      memcpy                                        #75.9
..___tag_value_pipeline_transfer.40:                            #
..LN231:
                                # LOE rax rbx rbp rsp r12 r13 r14 r15 rip
..B3.14:                        # Preds ..B3.7
..LN232:
        movq      %rax, -8(%rbp)                                #75.9
..LN233:
        jmp       ..B3.4        # Prob 100%                     #75.9
..LN234:
                                # LOE rbx rbp rsp r12 r13 r14 r15 rip
..B3.8:                         # Preds ..B3.4 ..B3.3 ..B3.6
..LN235:
   .loc    1  79  is_stmt 1
        movq      -40(%rbp), %rax                               #79.5
..LN236:
        movq      40(%rax), %rax                                #79.5
..LN237:
        movl      $1, %edx                                      #79.5
..LN238:
        movq      %rax, %rdi                                    #79.5
..LN239:
        movl      %edx, %ecx                                    #79.5
..LN240:
        lock      
        xaddl     %ecx, (%rdi)                                  #79.5
..LN241:
                                # LOE rbx rbp rsp r12 r13 r14 r15 rip ecx
..B3.15:                        # Preds ..B3.8
..LN242:
        movl      %ecx, -60(%rbp)                               #79.5
..LN243:
                                # LOE rbx rbp rsp r12 r13 r14 r15 rip
..B3.9:                         # Preds ..B3.15
..LN244:
   .loc    1  82  is_stmt 1
        leave                                                   #82.1
..___tag_value_pipeline_transfer.42:                            #
..LN245:
        ret                                                     #82.1
        .align    2,0x90
..___tag_value_pipeline_transfer.45:                            #
..LN246:
                                # LOE
..LN247:
# mark_end;
	.type	pipeline_transfer,@function
	.size	pipeline_transfer,.-pipeline_transfer
..LNpipeline_transfer.248:
.LNpipeline_transfer:
	.data
# -- End  pipeline_transfer
	.text
L__routine_start_init_affinity_3:
# -- Begin  init_affinity
# mark_begin;
# Threads 4
        .align    2,0x90
	.globl init_affinity
init_affinity:
# parameter 1(tid): %edi
..B4.1:                         # Preds ..B4.0
..___tag_value_init_affinity.47:                                #
..LN249:
   .loc    1  84  is_stmt 1
        pushq     %rbp                                          #84.28
..___tag_value_init_affinity.49:                                #
..LN250:
        movq      %rsp, %rbp                                    #84.28
..___tag_value_init_affinity.50:                                #
..LN251:
        subq      $192, %rsp                                    #84.28
..LN252:
        movq      %rbx, -8(%rbp)                                #84.28
..LN253:
        movl      %edi, -184(%rbp)                              #84.28
..___tag_value_init_affinity.53:                                #
..LN254:
                                # LOE rbp rsp r12 r13 r14 r15 rip
..B4.2:                         # Preds ..B4.3 ..B4.1
..LN255:
   .loc    1  86  is_stmt 1
        lea       -176(%rbp), %rax                              #86.5
..LN256:
        movl      $0, %edx                                      #86.5
..LN257:
        movl      $128, %ecx                                    #86.5
..LN258:
        movq      %rax, %rdi                                    #86.5
..LN259:
        movl      %edx, %eax                                    #86.5
..LN260:
        andl      $65535, %eax                                  #86.5
..LN261:
        movb      %al, %ah                                      #86.5
..LN262:
        movl      %eax, %edx                                    #86.5
..LN263:
        shll      $16, %eax                                     #86.5
..LN264:
        orl       %edx, %eax                                    #86.5
..LN265:
        movl      %ecx, %esi                                    #86.5
..LN266:
        shrq      $2, %rcx                                      #86.5
..LN267:
        movq      %rdi, %rdx                                    #86.5
..LN268:
        rep                                                     #86.5
..LN269:
        stosl                                                   #86.5
..LN270:
        movl      %esi, %ecx                                    #86.5
..LN271:
        andl      $3, %ecx                                      #86.5
..LN272:
        rep                                                     #86.5
..LN273:
        stosb                                                   #86.5
..LN274:
        movq      %rdx, %rax                                    #86.5
..LN275:
                                # LOE rax rbp rsp r12 r13 r14 r15 rip
..B4.10:                        # Preds ..B4.2
..LN276:
        movq      %rax, -48(%rbp)                               #86.5
..LN277:
                                # LOE rbp rsp r12 r13 r14 r15 rip
..B4.3:                         # Preds ..B4.10
..LN278:
        movl      $0, %eax                                      #86.5
..LN279:
        testl     %eax, %eax                                    #86.5
..LN280:
        jne       ..B4.2        # Prob 0%                       #86.5
..LN281:
                                # LOE rbp rsp r12 r13 r14 r15 rip
..B4.4:                         # Preds ..B4.3
..LN282:
   .loc    1  87  is_stmt 1
        movl      $1, %eax                                      #87.5
..LN283:
        addl      -184(%rbp), %eax                              #87.5
..LN284:
        movslq    %eax, %rax                                    #87.5
..LN285:
        movq      %rax, -40(%rbp)                               #87.5
..LN286:
        movq      -40(%rbp), %rax                               #87.5
..LN287:
        cmpq      $1024, %rax                                   #87.5
..LN288:
        jae       ..B4.6        # Prob 50%                      #87.5
..LN289:
                                # LOE rbp rsp r12 r13 r14 r15 rip
..B4.5:                         # Preds ..B4.4
..LN290:
        lea       -176(%rbp), %rax                              #87.5
..LN291:
        movq      -40(%rbp), %rdx                               #87.5
..LN292:
        shrq      $6, %rdx                                      #87.5
..LN293:
        imulq     $8, %rdx, %rdx                                #87.5
..LN294:
        addq      %rdx, %rax                                    #87.5
..LN295:
        movl      $1, %edx                                      #87.5
..LN296:
        movq      -40(%rbp), %rcx                               #87.5
..LN297:
        movl      $64, %ebx                                     #87.5
..LN298:
        movq      %rax, -24(%rbp)                               #87.5
..LN299:
        movq      %rcx, %rax                                    #87.5
..LN300:
        movq      %rdx, -16(%rbp)                               #87.5
..LN301:
        movl      $0, %edx                                      #87.5
..LN302:
        divq      %rbx                                          #87.5
..LN303:
        movl      %edx, %ecx                                    #87.5
..LN304:
        movq      -16(%rbp), %rax                               #87.5
..LN305:
        shlq      %cl, %rax                                     #87.5
..LN306:
        movq      -24(%rbp), %rdx                               #87.5
..LN307:
        orq       (%rdx), %rax                                  #87.5
..LN308:
        lea       -176(%rbp), %rdx                              #87.5
..LN309:
        movq      -40(%rbp), %rcx                               #87.5
..LN310:
        shrq      $6, %rcx                                      #87.5
..LN311:
        imulq     $8, %rcx, %rcx                                #87.5
..LN312:
        addq      %rcx, %rdx                                    #87.5
..LN313:
        movq      %rax, (%rdx)                                  #87.5
..LN314:
                                # LOE rbp rsp r12 r13 r14 r15 rip
..B4.6:                         # Preds ..B4.5 ..B4.4
..___tag_value_init_affinity.54:                                #89.28
..LN315:
   .loc    1  89  is_stmt 1
        call      pthread_self                                  #89.28
..___tag_value_init_affinity.55:                                #
..LN316:
                                # LOE rax rbp rsp r12 r13 r14 r15 rip
..B4.12:                        # Preds ..B4.6
..LN317:
        movq      %rax, -32(%rbp)                               #89.28
..LN318:
        movq      -32(%rbp), %rax                               #89.5
..LN319:
        movl      $128, %edx                                    #89.5
..LN320:
        lea       -176(%rbp), %rcx                              #89.5
..LN321:
        movq      %rax, %rdi                                    #89.5
..LN322:
        movq      %rdx, %rsi                                    #89.5
..LN323:
        movq      %rcx, %rdx                                    #89.5
..___tag_value_init_affinity.56:                                #89.5
..LN324:
        call      pthread_setaffinity_np                        #89.5
..___tag_value_init_affinity.57:                                #
..LN325:
                                # LOE rbp rsp r12 r13 r14 r15 rip eax
..B4.11:                        # Preds ..B4.12
..LN326:
        movl      %eax, -192(%rbp)                              #89.5
..LN327:
                                # LOE rbp rsp r12 r13 r14 r15 rip
..B4.7:                         # Preds ..B4.11
..LN328:
   .loc    1  91  is_stmt 1
        movq      -8(%rbp), %rbx                                #91.1
..___tag_value_init_affinity.58:                                #
..LN329:
        leave                                                   #91.1
..___tag_value_init_affinity.60:                                #
..LN330:
        ret                                                     #91.1
        .align    2,0x90
..___tag_value_init_affinity.63:                                #
..LN331:
                                # LOE
..LN332:
# mark_end;
	.type	init_affinity,@function
	.size	init_affinity,.-init_affinity
..LNinit_affinity.333:
.LNinit_affinity:
	.data
  .file   5 "/usr/linux-k1om-4.7/linux-k1om/usr/include/bits/sched.h"
  .file   6 "/usr/linux-k1om-4.7/linux-k1om/../lib/gcc/x86_64-k1om-linux/4.7.0/include/stddef.h"
# -- End  init_affinity
	.bss
	.align 4
	.align 4
	.globl count
count:
	.type	count,@object
	.size	count,4
	.space 4	# pad
	.align 4
	.globl scount
scount:
	.type	scount,@object
	.size	scount,4
	.space 4	# pad
	.align 4
	.globl rcount
rcount:
	.type	rcount,@object
	.size	rcount,4
	.space 4	# pad
	.data
# mark_proc_addr_taken pipeline_transfer;
	.section .note.GNU-stack, ""
	.global count#
	.global scount#
	.global rcount#
// -- Begin DWARF2 SEGMENT .debug_info
	.section .debug_info
.debug_info_seg:
	.align 1
	.4byte 0x000003c7
	.2byte 0x0002
	.4byte .debug_abbrev_seg
	.byte 0x08
//	DW_TAG_compile_unit:
	.byte 0x01
//	DW_AT_comp_dir:
	.4byte .debug_str
//	DW_AT_language:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x25
//	DW_AT_producer:
	.4byte .debug_str+0x30
//	DW_AT_stmt_list:
	.4byte .debug_line_seg
//	DW_TAG_base_type:
	.byte 0x02
//	DW_AT_byte_size:
	.byte 0x00
//	DW_AT_encoding:
	.byte 0x05
//	DW_AT_name:
	.4byte .debug_str+0xd8
//	DW_TAG_subprogram:
	.byte 0x03
//	DW_AT_decl_line:
	.byte 0x08
//	DW_AT_decl_column:
	.byte 0x06
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_inline:
	.byte 0x00
//	DW_AT_accessibility:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000001d
//	DW_AT_prototyped:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0xdd
	.4byte .debug_str+0xdd
//	DW_AT_low_pc:
	.8byte L__routine_start_do_strasnfer_0
//	DW_AT_high_pc:
	.8byte ..LNdo_strasnfer.91
//	DW_AT_external:
	.byte 0x01
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x08
//	DW_AT_decl_column:
	.byte 0x1f
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x000000ac
//	DW_AT_name:
	.4byte 0x00716572
//	DW_AT_location:
	.4byte 0x7bf07603
//	DW_TAG_variable:
	.byte 0x05
//	DW_AT_decl_line:
	.byte 0x0a
//	DW_AT_decl_column:
	.byte 0x13
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_accessibility:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x11f
//	DW_AT_type:
	.4byte 0x00000309
//	DW_AT_location:
	.4byte 0x7bf87603
//	DW_TAG_variable:
	.byte 0x05
//	DW_AT_decl_line:
	.byte 0x0b
//	DW_AT_decl_column:
	.byte 0x0a
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_accessibility:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x129
//	DW_AT_type:
	.4byte 0x00000304
//	DW_AT_location:
	.4byte 0x7c807603
//	DW_TAG_variable:
	.byte 0x05
//	DW_AT_decl_line:
	.byte 0x0c
//	DW_AT_decl_column:
	.byte 0x0a
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_accessibility:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x130
//	DW_AT_type:
	.4byte 0x00000304
//	DW_AT_location:
	.4byte 0x7c887603
//	DW_TAG_variable:
	.byte 0x05
//	DW_AT_decl_line:
	.byte 0x0d
//	DW_AT_decl_column:
	.byte 0x0f
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_accessibility:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x137
//	DW_AT_type:
	.4byte 0x00000313
//	DW_AT_location:
	.4byte 0x7c907603
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0x0f
//	DW_AT_decl_column:
	.byte 0x09
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_accessibility:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x0069
//	DW_AT_type:
	.4byte 0x000002fd
//	DW_AT_location:
	.4byte 0x7be47603
	.byte 0x00
//	DW_TAG_pointer_type:
	.byte 0x07
//	DW_AT_type:
	.4byte 0x000000b1
//	DW_TAG_typedef:
	.byte 0x08
//	DW_AT_decl_line:
	.byte 0x19
//	DW_AT_decl_column:
	.byte 0x02
//	DW_AT_decl_file:
	.byte 0x02
//	DW_AT_accessibility:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0xea
//	DW_AT_type:
	.4byte 0x000000be
//	DW_TAG_structure_type:
	.byte 0x09
//	DW_AT_decl_line:
	.byte 0x11
//	DW_AT_decl_column:
	.byte 0x10
//	DW_AT_decl_file:
	.byte 0x02
//	DW_AT_accessibility:
	.byte 0x01
//	DW_AT_byte_size:
	.byte 0x38
//	DW_AT_name:
	.4byte .debug_str+0xea
//	DW_TAG_member:
	.byte 0x0a
//	DW_AT_decl_line:
	.byte 0x12
//	DW_AT_decl_column:
	.byte 0x0f
//	DW_AT_decl_file:
	.byte 0x02
//	DW_AT_data_member_location:
	.2byte 0x2302
	.byte 0x00
//	DW_AT_name:
	.4byte .debug_str+0x10d
//	DW_AT_type:
	.4byte 0x000002e9
//	DW_TAG_member:
	.byte 0x0a
//	DW_AT_decl_line:
	.byte 0x13
//	DW_AT_decl_column:
	.byte 0x0f
//	DW_AT_decl_file:
	.byte 0x02
//	DW_AT_data_member_location:
	.2byte 0x2302
	.byte 0x08
//	DW_AT_name:
	.4byte .debug_str+0x112
//	DW_AT_type:
	.4byte 0x000002e9
//	DW_TAG_member:
	.byte 0x0a
//	DW_AT_decl_line:
	.byte 0x14
//	DW_AT_decl_column:
	.byte 0x09
//	DW_AT_decl_file:
	.byte 0x02
//	DW_AT_data_member_location:
	.2byte 0x2302
	.byte 0x10
//	DW_AT_name:
	.4byte .debug_str+0x117
//	DW_AT_type:
	.4byte 0x000002fd
//	DW_TAG_member:
	.byte 0x0a
//	DW_AT_decl_line:
	.byte 0x15
//	DW_AT_decl_column:
	.byte 0x0a
//	DW_AT_decl_file:
	.byte 0x02
//	DW_AT_data_member_location:
	.2byte 0x2302
	.byte 0x18
//	DW_AT_name:
	.4byte .debug_str+0x11f
//	DW_AT_type:
	.4byte 0x00000304
//	DW_TAG_member:
	.byte 0x0a
//	DW_AT_decl_line:
	.byte 0x16
//	DW_AT_decl_column:
	.byte 0x0a
//	DW_AT_decl_file:
	.byte 0x02
//	DW_AT_data_member_location:
	.2byte 0x2302
	.byte 0x20
//	DW_AT_name:
	.4byte .debug_str+0x129
//	DW_AT_type:
	.4byte 0x00000304
//	DW_TAG_member:
	.byte 0x0a
//	DW_AT_decl_line:
	.byte 0x17
//	DW_AT_decl_column:
	.byte 0x0a
//	DW_AT_decl_file:
	.byte 0x02
//	DW_AT_data_member_location:
	.2byte 0x2302
	.byte 0x28
//	DW_AT_name:
	.4byte .debug_str+0x130
//	DW_AT_type:
	.4byte 0x00000304
//	DW_TAG_member:
	.byte 0x0b
//	DW_AT_decl_line:
	.byte 0x18
//	DW_AT_decl_column:
	.byte 0x09
//	DW_AT_decl_file:
	.byte 0x02
//	DW_AT_data_member_location:
	.2byte 0x2302
	.byte 0x30
//	DW_AT_name:
	.4byte 0x00646974
//	DW_AT_type:
	.4byte 0x000002fd
	.byte 0x00
//	DW_TAG_subprogram:
	.byte 0x03
//	DW_AT_decl_line:
	.byte 0x22
//	DW_AT_decl_column:
	.byte 0x06
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_inline:
	.byte 0x00
//	DW_AT_accessibility:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000001d
//	DW_AT_prototyped:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x148
	.4byte .debug_str+0x148
//	DW_AT_low_pc:
	.8byte L__routine_start_do_rtrasnfer_1
//	DW_AT_high_pc:
	.8byte ..LNdo_rtrasnfer.151
//	DW_AT_external:
	.byte 0x01
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x22
//	DW_AT_decl_column:
	.byte 0x1f
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x000000ac
//	DW_AT_name:
	.4byte 0x00716572
//	DW_AT_location:
	.2byte 0x7602
	.byte 0x60
//	DW_TAG_variable:
	.byte 0x05
//	DW_AT_decl_line:
	.byte 0x23
//	DW_AT_decl_column:
	.byte 0x0f
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_accessibility:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x137
//	DW_AT_type:
	.4byte 0x0000032a
//	DW_AT_location:
	.2byte 0x7602
	.byte 0x50
//	DW_TAG_variable:
	.byte 0x05
//	DW_AT_decl_line:
	.byte 0x24
//	DW_AT_decl_column:
	.byte 0x13
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_accessibility:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x11f
//	DW_AT_type:
	.4byte 0x00000309
//	DW_AT_location:
	.2byte 0x7602
	.byte 0x68
//	DW_TAG_variable:
	.byte 0x05
//	DW_AT_decl_line:
	.byte 0x25
//	DW_AT_decl_column:
	.byte 0x0a
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_accessibility:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x129
//	DW_AT_type:
	.4byte 0x00000304
//	DW_AT_location:
	.2byte 0x7602
	.byte 0x70
//	DW_TAG_variable:
	.byte 0x05
//	DW_AT_decl_line:
	.byte 0x26
//	DW_AT_decl_column:
	.byte 0x0a
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_accessibility:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x130
//	DW_AT_type:
	.4byte 0x00000304
//	DW_AT_location:
	.2byte 0x7602
	.byte 0x78
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0x28
//	DW_AT_decl_column:
	.byte 0x09
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_accessibility:
	.byte 0x01
//	DW_AT_name:
	.2byte 0x0069
//	DW_AT_type:
	.4byte 0x000002fd
//	DW_AT_location:
	.2byte 0x7602
	.byte 0x54
	.byte 0x00
//	DW_TAG_subprogram:
	.byte 0x03
//	DW_AT_decl_line:
	.byte 0x3c
//	DW_AT_decl_column:
	.byte 0x06
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_inline:
	.byte 0x00
//	DW_AT_accessibility:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000001d
//	DW_AT_prototyped:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x155
	.4byte .debug_str+0x155
//	DW_AT_low_pc:
	.8byte L__routine_start_pipeline_transfer_2
//	DW_AT_high_pc:
	.8byte ..LNpipeline_transfer.248
//	DW_AT_external:
	.byte 0x01
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x3c
//	DW_AT_decl_column:
	.byte 0x1e
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x00000334
//	DW_AT_name:
	.2byte 0x0072
//	DW_AT_location:
	.2byte 0x7602
	.byte 0x50
//	DW_TAG_variable:
	.byte 0x06
//	DW_AT_decl_line:
	.byte 0x3d
//	DW_AT_decl_column:
	.byte 0x11
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_accessibility:
	.byte 0x01
//	DW_AT_name:
	.4byte 0x00716572
//	DW_AT_type:
	.4byte 0x000000ac
//	DW_AT_location:
	.2byte 0x7602
	.byte 0x58
//	DW_TAG_variable:
	.byte 0x05
//	DW_AT_decl_line:
	.byte 0x3f
//	DW_AT_decl_column:
	.byte 0x09
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_accessibility:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x167
//	DW_AT_type:
	.4byte 0x000002fd
//	DW_AT_location:
	.4byte 0x7fb47603
//	DW_TAG_variable:
	.byte 0x05
//	DW_AT_decl_line:
	.byte 0x41
//	DW_AT_decl_column:
	.byte 0x13
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_accessibility:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x11f
//	DW_AT_type:
	.4byte 0x00000309
//	DW_AT_location:
	.2byte 0x7602
	.byte 0x60
//	DW_TAG_variable:
	.byte 0x05
//	DW_AT_decl_line:
	.byte 0x42
//	DW_AT_decl_column:
	.byte 0x09
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_accessibility:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x117
//	DW_AT_type:
	.4byte 0x000002fd
//	DW_AT_location:
	.4byte 0x7fb87603
//	DW_TAG_variable:
	.byte 0x05
//	DW_AT_decl_line:
	.byte 0x43
//	DW_AT_decl_column:
	.byte 0x0f
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_accessibility:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x10d
//	DW_AT_type:
	.4byte 0x000002e9
//	DW_AT_location:
	.2byte 0x7602
	.byte 0x68
//	DW_TAG_variable:
	.byte 0x05
//	DW_AT_decl_line:
	.byte 0x44
//	DW_AT_decl_column:
	.byte 0x0f
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_accessibility:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x112
//	DW_AT_type:
	.4byte 0x000002e9
//	DW_AT_location:
	.2byte 0x7602
	.byte 0x70
//	DW_TAG_variable:
	.byte 0x05
//	DW_AT_decl_line:
	.byte 0x45
//	DW_AT_decl_column:
	.byte 0x09
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_accessibility:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x171
//	DW_AT_type:
	.4byte 0x000002fd
//	DW_AT_location:
	.4byte 0x7fbc7603
//	DW_TAG_lexical_block:
	.byte 0x0c
//	DW_AT_decl_line:
	.byte 0x47
//	DW_AT_decl_column:
	.byte 0x0e
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_low_pc:
	.8byte ..LN195
//	DW_AT_high_pc:
	.8byte ..LN235
//	DW_TAG_variable:
	.byte 0x05
//	DW_AT_decl_line:
	.byte 0x4a
//	DW_AT_decl_column:
	.byte 0x0d
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_accessibility:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x178
//	DW_AT_type:
	.4byte 0x000002fd
//	DW_AT_location:
	.2byte 0x7602
	.byte 0x48
	.byte 0x00
	.byte 0x00
//	DW_TAG_subprogram:
	.byte 0x03
//	DW_AT_decl_line:
	.byte 0x54
//	DW_AT_decl_column:
	.byte 0x06
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_inline:
	.byte 0x00
//	DW_AT_accessibility:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x0000001d
//	DW_AT_prototyped:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x17d
	.4byte .debug_str+0x17d
//	DW_AT_low_pc:
	.8byte L__routine_start_init_affinity_3
//	DW_AT_high_pc:
	.8byte ..LNinit_affinity.333
//	DW_AT_external:
	.byte 0x01
//	DW_TAG_formal_parameter:
	.byte 0x04
//	DW_AT_decl_line:
	.byte 0x54
//	DW_AT_decl_column:
	.byte 0x18
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_type:
	.4byte 0x000002fd
//	DW_AT_name:
	.4byte 0x00646974
//	DW_AT_location:
	.4byte 0x7ec87603
//	DW_TAG_variable:
	.byte 0x05
//	DW_AT_decl_line:
	.byte 0x55
//	DW_AT_decl_column:
	.byte 0x0f
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_accessibility:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x18b
//	DW_AT_type:
	.4byte 0x00000339
//	DW_AT_location:
	.4byte 0x7ed07603
//	DW_TAG_lexical_block:
	.byte 0x0c
//	DW_AT_decl_line:
	.byte 0x57
//	DW_AT_decl_column:
	.byte 0x05
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_low_pc:
	.8byte ..LN282
//	DW_AT_high_pc:
	.8byte ..LN315
//	DW_TAG_variable:
	.byte 0x05
//	DW_AT_decl_line:
	.byte 0x57
//	DW_AT_decl_column:
	.byte 0x05
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_accessibility:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x1ac
//	DW_AT_type:
	.4byte 0x00000372
//	DW_AT_location:
	.2byte 0x7602
	.byte 0x58
	.byte 0x00
	.byte 0x00
//	DW_TAG_typedef:
	.byte 0x08
//	DW_AT_decl_line:
	.byte 0x7b
//	DW_AT_decl_column:
	.byte 0x1b
//	DW_AT_decl_file:
	.byte 0x03
//	DW_AT_accessibility:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0xf5
//	DW_AT_type:
	.4byte 0x000002f6
//	DW_TAG_base_type:
	.byte 0x02
//	DW_AT_byte_size:
	.byte 0x08
//	DW_AT_encoding:
	.byte 0x07
//	DW_AT_name:
	.4byte .debug_str+0xff
//	DW_TAG_base_type:
	.byte 0x0d
//	DW_AT_byte_size:
	.byte 0x04
//	DW_AT_encoding:
	.byte 0x05
//	DW_AT_name:
	.4byte 0x00746e69
//	DW_TAG_pointer_type:
	.byte 0x07
//	DW_AT_type:
	.4byte 0x000002fd
//	DW_TAG_pointer_type:
	.byte 0x07
//	DW_AT_type:
	.4byte 0x0000030e
//	DW_TAG_volatile_type:
	.byte 0x0e
//	DW_AT_type:
	.4byte 0x000002fd
//	DW_TAG_array_type:
	.byte 0x0f
//	DW_AT_type:
	.4byte 0x0000031d
//	DW_AT_byte_size:
	.2byte 0x01e0
//	DW_TAG_subrange_type:
	.byte 0x10
//	DW_AT_upper_bound:
	.byte 0x3b
	.byte 0x00
//	DW_TAG_typedef:
	.byte 0x08
//	DW_AT_decl_line:
	.byte 0x32
//	DW_AT_decl_column:
	.byte 0x1b
//	DW_AT_decl_file:
	.byte 0x04
//	DW_AT_accessibility:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x13e
//	DW_AT_type:
	.4byte 0x000002f6
//	DW_TAG_array_type:
	.byte 0x0f
//	DW_AT_type:
	.4byte 0x0000031d
//	DW_AT_byte_size:
	.2byte 0x01e0
//	DW_TAG_subrange_type:
	.byte 0x10
//	DW_AT_upper_bound:
	.byte 0x3b
	.byte 0x00
//	DW_TAG_pointer_type:
	.byte 0x07
//	DW_AT_type:
	.4byte 0x0000001d
//	DW_TAG_typedef:
	.byte 0x08
//	DW_AT_decl_line:
	.byte 0x82
//	DW_AT_decl_column:
	.byte 0x03
//	DW_AT_decl_file:
	.byte 0x05
//	DW_AT_accessibility:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x190
//	DW_AT_type:
	.4byte 0x00000346
//	DW_TAG_structure_type:
	.byte 0x11
//	DW_AT_decl_line:
	.byte 0x80
//	DW_AT_decl_column:
	.byte 0x01
//	DW_AT_decl_file:
	.byte 0x05
//	DW_AT_accessibility:
	.byte 0x01
//	DW_AT_byte_size:
	.byte 0x80
//	DW_TAG_member:
	.byte 0x0a
//	DW_AT_decl_line:
	.byte 0x81
//	DW_AT_decl_column:
	.byte 0x0e
//	DW_AT_decl_file:
	.byte 0x05
//	DW_AT_data_member_location:
	.2byte 0x2302
	.byte 0x00
//	DW_AT_name:
	.4byte .debug_str+0x1a5
//	DW_AT_type:
	.4byte 0x0000035c
	.byte 0x00
//	DW_TAG_array_type:
	.byte 0x12
//	DW_AT_type:
	.4byte 0x00000365
//	DW_AT_byte_size:
	.byte 0x80
//	DW_TAG_subrange_type:
	.byte 0x10
//	DW_AT_upper_bound:
	.byte 0x0f
	.byte 0x00
//	DW_TAG_typedef:
	.byte 0x08
//	DW_AT_decl_line:
	.byte 0x78
//	DW_AT_decl_column:
	.byte 0x1b
//	DW_AT_decl_file:
	.byte 0x05
//	DW_AT_accessibility:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x19a
//	DW_AT_type:
	.4byte 0x000002f6
//	DW_TAG_typedef:
	.byte 0x08
//	DW_AT_decl_line:
	.byte 0xd4
//	DW_AT_decl_column:
	.byte 0x17
//	DW_AT_decl_file:
	.byte 0x06
//	DW_AT_accessibility:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x1b2
//	DW_AT_type:
	.4byte 0x000002f6
//	DW_TAG_variable:
	.byte 0x13
//	DW_AT_decl_line:
	.byte 0x05
//	DW_AT_decl_column:
	.byte 0x05
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_accessibility:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x1b9
//	DW_AT_type:
	.4byte 0x000002fd
//	DW_AT_location:
	.2byte 0x0309
	.8byte count
//	DW_AT_external:
	.byte 0x01
//	DW_TAG_variable:
	.byte 0x13
//	DW_AT_decl_line:
	.byte 0x06
//	DW_AT_decl_column:
	.byte 0x05
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_accessibility:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x1bf
//	DW_AT_type:
	.4byte 0x000002fd
//	DW_AT_location:
	.2byte 0x0309
	.8byte scount
//	DW_AT_external:
	.byte 0x01
//	DW_TAG_variable:
	.byte 0x13
//	DW_AT_decl_line:
	.byte 0x07
//	DW_AT_decl_column:
	.byte 0x05
//	DW_AT_decl_file:
	.byte 0x01
//	DW_AT_accessibility:
	.byte 0x01
//	DW_AT_name:
	.4byte .debug_str+0x1c6
//	DW_AT_type:
	.4byte 0x000002fd
//	DW_AT_location:
	.2byte 0x0309
	.8byte rcount
//	DW_AT_external:
	.byte 0x01
	.byte 0x00
	.byte 0x00
	.byte 0x00
	.byte 0x00
// -- Begin DWARF2 SEGMENT .debug_line
	.section .debug_line
.debug_line_seg:
	.align 1
// -- Begin DWARF2 SEGMENT .debug_abbrev
	.section .debug_abbrev
.debug_abbrev_seg:
	.align 1
	.byte 0x01
	.byte 0x11
	.byte 0x01
	.byte 0x1b
	.byte 0x0e
	.byte 0x13
	.byte 0x0b
	.byte 0x03
	.byte 0x0e
	.byte 0x25
	.byte 0x0e
	.byte 0x10
	.byte 0x06
	.2byte 0x0000
	.byte 0x02
	.byte 0x24
	.byte 0x00
	.byte 0x0b
	.byte 0x0b
	.byte 0x3e
	.byte 0x0b
	.byte 0x03
	.byte 0x0e
	.2byte 0x0000
	.byte 0x03
	.byte 0x2e
	.byte 0x01
	.byte 0x3b
	.byte 0x0b
	.byte 0x39
	.byte 0x0b
	.byte 0x3a
	.byte 0x0b
	.byte 0x20
	.byte 0x0b
	.byte 0x32
	.byte 0x0b
	.byte 0x49
	.byte 0x13
	.byte 0x27
	.byte 0x0c
	.byte 0x03
	.byte 0x0e
	.2byte 0x4087
	.byte 0x0e
	.byte 0x11
	.byte 0x01
	.byte 0x12
	.byte 0x01
	.byte 0x3f
	.byte 0x0c
	.2byte 0x0000
	.byte 0x04
	.byte 0x05
	.byte 0x00
	.byte 0x3b
	.byte 0x0b
	.byte 0x39
	.byte 0x0b
	.byte 0x3a
	.byte 0x0b
	.byte 0x49
	.byte 0x13
	.byte 0x03
	.byte 0x08
	.byte 0x02
	.byte 0x0a
	.2byte 0x0000
	.byte 0x05
	.byte 0x34
	.byte 0x00
	.byte 0x3b
	.byte 0x0b
	.byte 0x39
	.byte 0x0b
	.byte 0x3a
	.byte 0x0b
	.byte 0x32
	.byte 0x0b
	.byte 0x03
	.byte 0x0e
	.byte 0x49
	.byte 0x13
	.byte 0x02
	.byte 0x0a
	.2byte 0x0000
	.byte 0x06
	.byte 0x34
	.byte 0x00
	.byte 0x3b
	.byte 0x0b
	.byte 0x39
	.byte 0x0b
	.byte 0x3a
	.byte 0x0b
	.byte 0x32
	.byte 0x0b
	.byte 0x03
	.byte 0x08
	.byte 0x49
	.byte 0x13
	.byte 0x02
	.byte 0x0a
	.2byte 0x0000
	.byte 0x07
	.byte 0x0f
	.byte 0x00
	.byte 0x49
	.byte 0x13
	.2byte 0x0000
	.byte 0x08
	.byte 0x16
	.byte 0x00
	.byte 0x3b
	.byte 0x0b
	.byte 0x39
	.byte 0x0b
	.byte 0x3a
	.byte 0x0b
	.byte 0x32
	.byte 0x0b
	.byte 0x03
	.byte 0x0e
	.byte 0x49
	.byte 0x13
	.2byte 0x0000
	.byte 0x09
	.byte 0x13
	.byte 0x01
	.byte 0x3b
	.byte 0x0b
	.byte 0x39
	.byte 0x0b
	.byte 0x3a
	.byte 0x0b
	.byte 0x32
	.byte 0x0b
	.byte 0x0b
	.byte 0x0b
	.byte 0x03
	.byte 0x0e
	.2byte 0x0000
	.byte 0x0a
	.byte 0x0d
	.byte 0x00
	.byte 0x3b
	.byte 0x0b
	.byte 0x39
	.byte 0x0b
	.byte 0x3a
	.byte 0x0b
	.byte 0x38
	.byte 0x0a
	.byte 0x03
	.byte 0x0e
	.byte 0x49
	.byte 0x13
	.2byte 0x0000
	.byte 0x0b
	.byte 0x0d
	.byte 0x00
	.byte 0x3b
	.byte 0x0b
	.byte 0x39
	.byte 0x0b
	.byte 0x3a
	.byte 0x0b
	.byte 0x38
	.byte 0x0a
	.byte 0x03
	.byte 0x08
	.byte 0x49
	.byte 0x13
	.2byte 0x0000
	.byte 0x0c
	.byte 0x0b
	.byte 0x01
	.byte 0x3b
	.byte 0x0b
	.byte 0x39
	.byte 0x0b
	.byte 0x3a
	.byte 0x0b
	.byte 0x11
	.byte 0x01
	.byte 0x12
	.byte 0x01
	.2byte 0x0000
	.byte 0x0d
	.byte 0x24
	.byte 0x00
	.byte 0x0b
	.byte 0x0b
	.byte 0x3e
	.byte 0x0b
	.byte 0x03
	.byte 0x08
	.2byte 0x0000
	.byte 0x0e
	.byte 0x35
	.byte 0x00
	.byte 0x49
	.byte 0x13
	.2byte 0x0000
	.byte 0x0f
	.byte 0x01
	.byte 0x01
	.byte 0x49
	.byte 0x13
	.byte 0x0b
	.byte 0x05
	.2byte 0x0000
	.byte 0x10
	.byte 0x21
	.byte 0x00
	.byte 0x2f
	.byte 0x0b
	.2byte 0x0000
	.byte 0x11
	.byte 0x13
	.byte 0x01
	.byte 0x3b
	.byte 0x0b
	.byte 0x39
	.byte 0x0b
	.byte 0x3a
	.byte 0x0b
	.byte 0x32
	.byte 0x0b
	.byte 0x0b
	.byte 0x0b
	.2byte 0x0000
	.byte 0x12
	.byte 0x01
	.byte 0x01
	.byte 0x49
	.byte 0x13
	.byte 0x0b
	.byte 0x0b
	.2byte 0x0000
	.byte 0x13
	.byte 0x34
	.byte 0x00
	.byte 0x3b
	.byte 0x0b
	.byte 0x39
	.byte 0x0b
	.byte 0x3a
	.byte 0x0b
	.byte 0x32
	.byte 0x0b
	.byte 0x03
	.byte 0x0e
	.byte 0x49
	.byte 0x13
	.byte 0x02
	.byte 0x0a
	.byte 0x3f
	.byte 0x0c
	.2byte 0x0000
	.byte 0x00
// -- Begin DWARF2 SEGMENT .debug_frame
	.section .debug_frame
.debug_frame_seg:
	.align 1
	.4byte 0x00000014
	.8byte 0x78010001ffffffff
	.8byte 0x0000019008070c10
	.4byte 0x00000000
	.4byte 0x0000003c
	.4byte .debug_frame_seg
	.8byte ..___tag_value_do_strasnfer.2
	.8byte ..___tag_value_do_strasnfer.16-..___tag_value_do_strasnfer.2
	.byte 0x04
	.4byte ..___tag_value_do_strasnfer.4-..___tag_value_do_strasnfer.2
	.2byte 0x100e
	.byte 0x04
	.4byte ..___tag_value_do_strasnfer.5-..___tag_value_do_strasnfer.4
	.4byte 0x8610060c
	.2byte 0x0402
	.4byte ..___tag_value_do_strasnfer.8-..___tag_value_do_strasnfer.5
	.2byte 0x0483
	.byte 0x04
	.4byte ..___tag_value_do_strasnfer.11-..___tag_value_do_strasnfer.8
	.2byte 0x04c3
	.4byte ..___tag_value_do_strasnfer.13-..___tag_value_do_strasnfer.11
	.4byte 0x000000c6
	.byte 0x00
	.4byte 0x0000002c
	.4byte .debug_frame_seg
	.8byte ..___tag_value_do_rtrasnfer.18
	.8byte ..___tag_value_do_rtrasnfer.28-..___tag_value_do_rtrasnfer.18
	.byte 0x04
	.4byte ..___tag_value_do_rtrasnfer.20-..___tag_value_do_rtrasnfer.18
	.2byte 0x100e
	.byte 0x04
	.4byte ..___tag_value_do_rtrasnfer.21-..___tag_value_do_rtrasnfer.20
	.4byte 0x8610060c
	.2byte 0x0402
	.4byte ..___tag_value_do_rtrasnfer.25-..___tag_value_do_rtrasnfer.21
	.2byte 0x00c6
	.4byte 0x0000002c
	.4byte .debug_frame_seg
	.8byte ..___tag_value_pipeline_transfer.30
	.8byte ..___tag_value_pipeline_transfer.45-..___tag_value_pipeline_transfer.30
	.byte 0x04
	.4byte ..___tag_value_pipeline_transfer.32-..___tag_value_pipeline_transfer.30
	.2byte 0x100e
	.byte 0x04
	.4byte ..___tag_value_pipeline_transfer.33-..___tag_value_pipeline_transfer.32
	.4byte 0x8610060c
	.2byte 0x0402
	.4byte ..___tag_value_pipeline_transfer.42-..___tag_value_pipeline_transfer.33
	.2byte 0x00c6
	.4byte 0x0000003c
	.4byte .debug_frame_seg
	.8byte ..___tag_value_init_affinity.47
	.8byte ..___tag_value_init_affinity.63-..___tag_value_init_affinity.47
	.byte 0x04
	.4byte ..___tag_value_init_affinity.49-..___tag_value_init_affinity.47
	.2byte 0x100e
	.byte 0x04
	.4byte ..___tag_value_init_affinity.50-..___tag_value_init_affinity.49
	.4byte 0x8610060c
	.2byte 0x0402
	.4byte ..___tag_value_init_affinity.53-..___tag_value_init_affinity.50
	.2byte 0x0383
	.byte 0x04
	.4byte ..___tag_value_init_affinity.58-..___tag_value_init_affinity.53
	.2byte 0x04c3
	.4byte ..___tag_value_init_affinity.60-..___tag_value_init_affinity.58
	.4byte 0x000000c6
	.byte 0x00
// -- Begin DWARF2 SEGMENT .debug_str
	.section .debug_str,"MS",@progbits,1
.debug_str_seg:
	.align 1
	.8byte 0x302f31656d6f682f
	.8byte 0x7773752f36333632
	.8byte 0x79532f61726b6369
	.8byte 0x74736572702f636e
	.4byte 0x322e3161
	.byte 0x00
	.8byte 0x726566736e617274
	.2byte 0x632e
	.byte 0x00
	.8byte 0x2952286c65746e49
	.8byte 0x6c65746e49204320
	.8byte 0x4320343620295228
	.8byte 0x2072656c69706d6f
	.8byte 0x6120726f66204558
	.8byte 0x69746163696c7070
	.8byte 0x6e6e757220736e6f
	.8byte 0x49206e6f20676e69
	.8byte 0x202952286c65746e
	.8byte 0x686372412043494d
	.8byte 0x6572757463657469
	.8byte 0x6f6973726556202c
	.8byte 0x302e312e3331206e
	.8byte 0x746542203634312e
	.8byte 0x20646c6975422061
	.8byte 0x3132313033313032
	.8byte 0x207365786946200a
	.8byte 0x6b6e694c656d6153
	.8byte 0x20656d614e656761
	.8byte 0x6f507265626d654d
	.8byte 0x000a737265746e69
	.4byte 0x64696f76
	.byte 0x00
	.8byte 0x73617274735f6f64
	.4byte 0x7265666e
	.byte 0x00
	.8byte 0x6575716572687470
	.2byte 0x7473
	.byte 0x00
	.8byte 0x5f727470746e6975
	.2byte 0x0074
	.8byte 0x64656e6769736e75
	.4byte 0x6e6f6c20
	.2byte 0x0067
	.4byte 0x66756273
	.byte 0x00
	.4byte 0x66756272
	.byte 0x00
	.8byte 0x00657a6973667562
	.8byte 0x747074657366666f
	.2byte 0x0072
	.4byte 0x79735f73
	.2byte 0x636e
	.byte 0x00
	.4byte 0x79735f72
	.2byte 0x636e
	.byte 0x00
	.4byte 0x65726874
	.2byte 0x6461
	.byte 0x00
	.8byte 0x5f64616572687470
	.2byte 0x0074
	.8byte 0x73617274725f6f64
	.4byte 0x7265666e
	.byte 0x00
	.8byte 0x656e696c65706970
	.8byte 0x6566736e6172745f
	.2byte 0x0072
	.8byte 0x69745f6c61636f6c
	.2byte 0x0064
	.4byte 0x7366666f
	.2byte 0x7465
	.byte 0x00
	.4byte 0x7466656c
	.byte 0x00
	.8byte 0x6666615f74696e69
	.4byte 0x74696e69
	.2byte 0x0079
	.4byte 0x6b73616d
	.byte 0x00
	.8byte 0x5f7465735f757063
	.2byte 0x0074
	.8byte 0x616d5f7570635f5f
	.2byte 0x6b73
	.byte 0x00
	.4byte 0x69625f5f
	.2byte 0x7374
	.byte 0x00
	.4byte 0x70635f5f
	.2byte 0x0075
	.4byte 0x657a6973
	.2byte 0x745f
	.byte 0x00
	.4byte 0x6e756f63
	.2byte 0x0074
	.4byte 0x756f6373
	.2byte 0x746e
	.byte 0x00
	.4byte 0x756f6372
	.2byte 0x746e
	.byte 0x00
// -- Begin DWARF2 SEGMENT .eh_frame
	.section .eh_frame,"a",@progbits
.eh_frame_seg:
	.align 8
	.4byte 0x00000014
	.8byte 0x7801000100000000
	.8byte 0x0000019008070c10
	.4byte 0x00000000
	.4byte 0x0000003c
	.4byte 0x0000001c
	.8byte ..___tag_value_do_strasnfer.2
	.8byte ..___tag_value_do_strasnfer.16-..___tag_value_do_strasnfer.2
	.byte 0x04
	.4byte ..___tag_value_do_strasnfer.4-..___tag_value_do_strasnfer.2
	.2byte 0x100e
	.byte 0x04
	.4byte ..___tag_value_do_strasnfer.5-..___tag_value_do_strasnfer.4
	.4byte 0x8610060c
	.2byte 0x0402
	.4byte ..___tag_value_do_strasnfer.8-..___tag_value_do_strasnfer.5
	.2byte 0x0483
	.byte 0x04
	.4byte ..___tag_value_do_strasnfer.11-..___tag_value_do_strasnfer.8
	.2byte 0x04c3
	.4byte ..___tag_value_do_strasnfer.13-..___tag_value_do_strasnfer.11
	.4byte 0x000000c6
	.byte 0x00
	.4byte 0x0000002c
	.4byte 0x0000005c
	.8byte ..___tag_value_do_rtrasnfer.18
	.8byte ..___tag_value_do_rtrasnfer.28-..___tag_value_do_rtrasnfer.18
	.byte 0x04
	.4byte ..___tag_value_do_rtrasnfer.20-..___tag_value_do_rtrasnfer.18
	.2byte 0x100e
	.byte 0x04
	.4byte ..___tag_value_do_rtrasnfer.21-..___tag_value_do_rtrasnfer.20
	.4byte 0x8610060c
	.2byte 0x0402
	.4byte ..___tag_value_do_rtrasnfer.25-..___tag_value_do_rtrasnfer.21
	.2byte 0x00c6
	.4byte 0x0000002c
	.4byte 0x0000008c
	.8byte ..___tag_value_pipeline_transfer.30
	.8byte ..___tag_value_pipeline_transfer.45-..___tag_value_pipeline_transfer.30
	.byte 0x04
	.4byte ..___tag_value_pipeline_transfer.32-..___tag_value_pipeline_transfer.30
	.2byte 0x100e
	.byte 0x04
	.4byte ..___tag_value_pipeline_transfer.33-..___tag_value_pipeline_transfer.32
	.4byte 0x8610060c
	.2byte 0x0402
	.4byte ..___tag_value_pipeline_transfer.42-..___tag_value_pipeline_transfer.33
	.2byte 0x00c6
	.4byte 0x0000003c
	.4byte 0x000000bc
	.8byte ..___tag_value_init_affinity.47
	.8byte ..___tag_value_init_affinity.63-..___tag_value_init_affinity.47
	.byte 0x04
	.4byte ..___tag_value_init_affinity.49-..___tag_value_init_affinity.47
	.2byte 0x100e
	.byte 0x04
	.4byte ..___tag_value_init_affinity.50-..___tag_value_init_affinity.49
	.4byte 0x8610060c
	.2byte 0x0402
	.4byte ..___tag_value_init_affinity.53-..___tag_value_init_affinity.50
	.2byte 0x0383
	.byte 0x04
	.4byte ..___tag_value_init_affinity.58-..___tag_value_init_affinity.53
	.2byte 0x04c3
	.4byte ..___tag_value_init_affinity.60-..___tag_value_init_affinity.58
	.4byte 0x000000c6
	.byte 0x00
	.section .text
.LNDBG_TXe:
# End
