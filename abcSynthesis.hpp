extern "C"{
    // procedures to start and stop the ABC framework
    // (should be called before and after the ABC procedures are called)
    void   Abc_Start();
    void   Abc_Stop();

    // procedures to get the ABC framework and execute commands in it
    typedef struct Abc_Frame_t_ Abc_Frame_t;

    Abc_Frame_t * Abc_FrameGetGlobalFrame();
    int    Cmd_CommandExecute( Abc_Frame_t * pAbc, const char * sCommand );
}