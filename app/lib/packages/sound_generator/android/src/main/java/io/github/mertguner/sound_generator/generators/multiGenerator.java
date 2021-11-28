package io.github.mertguner.sound_generator.generators;

public class multiGenerator extends baseGenerator {
    private double[] tone_hz;
    private double[] tone_mod_hz;

    private double angle2=0;
    private double tone_pow=3;
    private int tone_steps=7;
    private double tone_mod=1024;
    private double tone_shift=3;
    //sub 400-200, main 200-20000
    //all
    private double tone_hz_min=25;
    private double tone_hz_max=20000;

    private boolean dumped=false;

    private double[] multi_hz;
    private double[] multi_mod_hz;
    
    private int multi_steps=7;


    private double frequency = 50;

    private int audio=0;

    public multiGenerator()
    {
        this.tone_hz = new double[tone_steps];
        this.tone_mod_hz = new double[tone_steps];
    }

    private double modulationHzGet(double target, double modulation)
    {
        dumped=false;
        if(modulation==0) return 0;
        if(modulation<0) {dumped=true;modulation=-modulation;}
        return target/modulation;
    }

    private void multiHzAdd(double target, double modulation, double multi, int updown, boolean first)
    {
        if ((target>tone_hz_min)&&(target<tone_hz_max)) { 
            if ((!first)||(!(updown==1)))
            {
                multi_hz[multi_steps]=target;
                multi_mod_hz[multi_steps]=modulationHzGet(target,modulation);
                
                android.util.Log.d("SoundHealer", "multi_hz["+multi_steps+"]="+multi_hz[multi_steps]);
                android.util.Log.d("SoundHealer", "multi_mod_hz["+multi_steps+"]="+multi_mod_hz[multi_steps]);

                multi_steps++;
            }
            
            if (multi==1) return;
        }


android.util.Log.d("SoundHealer","1");
        if ((updown==1)&&(target>tone_hz_max)) return;
        android.util.Log.d("SoundHealer","2");
        if ((updown==-1)&&(target<tone_hz_min)) return;
android.util.Log.d("SoundHealer","3");
            
        if (multi==2) multiHzAdd(Math.pow(target,2*updown), modulation, multi,updown,false);
        if (multi==3) multiHzAdd(Math.pow(target,3*updown), modulation, multi,updown,false);
        if (multi==5) multiHzAdd(Math.pow(target,5*updown), modulation, multi,updown,false);

        if (multi==23) {multiHzAdd(Math.pow(target,2*updown), modulation, multi,updown,false);multiHzAdd(Math.pow(target,3*updown), modulation, multi,updown,false);}
        if (multi==25) {multiHzAdd(Math.pow(target,2*updown), modulation, multi,updown,false);multiHzAdd(Math.pow(target,5*updown), modulation, multi,updown,false);}

        if (multi==235) {multiHzAdd(Math.pow(target,2*updown), modulation, multi,updown,false);multiHzAdd(Math.pow(target,3*updown), modulation, multi,updown,false);multiHzAdd(Math.pow(target,5*updown), modulation, multi,updown,false);}
    
        if (multi==123) multiHzAdd(Math.pow(target,1.58496250072*updown), modulation, multi,updown,false);
        if (multi==74) multiHzAdd(Math.pow(target,7.0/4.0*updown), modulation, multi,updown,false);
    
        android.util.Log.d("SoundHealer","4");
    }

    private void multiHz(double target, double modulation, double multi)
    {
        multi_steps=0;
        this.multi_hz = new double[100];
        this.multi_mod_hz = new double[100];
        
        multiHzAdd(target, modulation, multi,1,true);
        multiHzAdd(target, modulation, multi,-1,true);
    }

    private void setAngle(double channel)
    {
            angle2=0;
            if (channel==60) {
                angle2=(Math.PI*2/6);
            }            
            if (channel==90) {
                angle2=(Math.PI*2/4);
            }
            if (channel==120) {
                angle2=(Math.PI*2/3);
            }
            if (channel==180) {
                angle2=(Math.PI*2/2);
            }
            if (channel==137) {
                angle2=2.39996322972865332; // TODO : 2*137.5/360 //Math.PI*(3-sqrt(5)
            }
            
    }

    public void setParams(double target, double enviroment, double modulation, double multi, double channel, double audio) {
        android.util.Log.d("SoundHealer", "target="+target);
        android.util.Log.d("SoundHealer", "enviroment="+enviroment);
        android.util.Log.d("SoundHealer", "modulation="+modulation);
        android.util.Log.d("SoundHealer", "multi="+multi);
        android.util.Log.d("SoundHealer", "channel="+channel);
        android.util.Log.d("SoundHealer", "audio="+audio);

        this.audio=(int)audio;
        setAngle(channel);

        multiHz(target, modulation, multi);
    }

    public void setFrequency(float frequency) {
        /*
        this.frequency = frequency;
        android.util.Log.d("SoundHealer", "frequency="+frequency);
        
        tone_shift=3;
        
        if (frequency>400000) tone_shift=-4;
        if (frequency>900000) tone_shift=-4;
        if (frequency>1900000) tone_shift=-5;

        android.util.Log.d("SoundHealer", "tone_shift="+tone_shift);
        for(int i=0;i<tone_steps;i++)
        {
            tone_hz[i]=frequency/Math.pow(tone_pow,i-tone_shift);
            if (tone_hz[i]<tone_hz_min) {android.util.Log.d("SoundHealer", tone_hz[i]+"<min => 0"); tone_hz[i]=0; }
            if (tone_hz[i]>tone_hz_max) {android.util.Log.d("SoundHealer", tone_hz[i]+">max => 0"); tone_hz[i]=0; }
            android.util.Log.d("SoundHealer", "tone_hz["+i+"]="+tone_hz[i]);
        }

        for(int i=0;i<tone_steps;i++)
            tone_mod_hz[i]=tone_hz[i]/tone_mod;
        */
    }

    public void getBuffer(short[] backgroundBuffer, int sampleRate, int position, int bufferSamplesSize)
    {
        android.util.Log.d("SoundHealer/multi/getBuffer", "sampleRate="+sampleRate+",position="+position+",bufferSamplesSize="+bufferSamplesSize);
        double y,y_step,t1,t2,mod_amplitude;
        int x;
        //int y_int;
        short y_short;

        android.util.Log.d("SoundHealer", "Buffer start position="+position);

        for (int xp = 0; xp < bufferSamplesSize; xp++) {
            x=(position*bufferSamplesSize)+xp;
            backgroundBuffer[xp]=(short) (Short.MAX_VALUE * Math.sin(x/100000));
        }
        android.util.Log.d("SoundHealer", "Buffer end"+(int)(position*bufferSamplesSize));
        android.util.Log.d("SoundHealer", "Buffer end");
    }

    public short getValue(double phase, double period) {
        return 0;
    }

    public short getValuePos(int xp, int sampleRate, int position, int bufferSamplesSize, int channel) {
        double y=getValuePosDouble(xp, sampleRate, position, bufferSamplesSize, channel);
        return (short)(y*Short.MAX_VALUE);
    }

    public int getValuePosInt(int xp, int sampleRate, int position, int bufferSamplesSize, int channel) {
        double y=getValuePosDouble(xp, sampleRate, position, bufferSamplesSize, channel);
        return (int)(y*Short.MAX_VALUE);
    }

    public float getValuePosFloat(int xp, int sampleRate, int position, int bufferSamplesSize, int channel) {
        //!!! Возможно просто стоит перейти на 32 Bit
        //!!! Важно. Float возможно не самое лучшее решение, т.к. у основной гармоники наибольшая точность, у остальных пострадает. Пока не ясно...
        double y=getValuePosDouble(xp, sampleRate, position, bufferSamplesSize, channel);
        return (float)(y*Short.MAX_VALUE);
    }

    public double getValuePosDouble(int xp, int sampleRate, int position, int bufferSamplesSize, int channel) {

        double y,y_step,t1,t2,mod_amplitude;
        int x;

        x=(position*bufferSamplesSize)+xp;


        y=0;

        for(int step=0;step<tone_steps;step++) {
            if (tone_hz[step]==0) continue;
            t1=(tone_mod_hz[step]*x/sampleRate)*Math.PI*2;
            t2=(tone_hz[step]*x/sampleRate)*Math.PI*2;
            
            if(channel==2)
            {
                t1=t1+angle2;
                t2=t2+angle2;
            }
            


            mod_amplitude=Math.sin(t1);
            if (audio==1333) {
                mod_amplitude=1.0-Math.sin((t1 % (Math.PI/2)));                
            }

            y_step=Math.sin(t2)*((mod_amplitude+1)/2); //AM modulation, volume positive

            y_step=y_step/(Math.pow(tone_pow,(tone_steps-1-step)));

            y=y+y_step;        
        }

        y=y/(1.0+0.5+0.25+0.125+0.0625+0.03125+0.015625);
        
        return y;
    }
}
