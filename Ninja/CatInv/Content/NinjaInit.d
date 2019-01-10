/*
 * Initialization function called by Ninja after "Init_Global" (G2) / "Init_<Levelname>" (G1)
 */
func void Ninja_CatInv_Init() {
    MEM_InitAll();
    invInit();
};
