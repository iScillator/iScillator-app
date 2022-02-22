package io.github.mertguner.sound_generator.generators;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class multiGenerator extends baseGenerator {
    private double target;
    private double[] targets;
    private int targets_count=0;

    private double[] tone_hz;
    private double[] tone_mod_hz;

    
    private double angle=0;
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
    private double[] multi_amp;
    private double amp_sum;

    private double multi_amp_diff=0;

    private double multi;
    private double modulation;
    private double meandr;

    private int multi_steps=7;


    private double frequency = 50;
    private double mod_frequency = 50.0/1024.0;

    private int audio=0;

    private int autonext=0;

    public multiGenerator()
    {
        this.tone_hz = new double[tone_steps];
        this.tone_mod_hz = new double[tone_steps];
    }

    private double modulationHzGet(double target, double modulation)
    {
        if(modulation==0) return 0;
        
        if (modulation==10241) modulation=1024;
        if (modulation==10242) modulation=1024;
        if (modulation==10243) modulation=1024;

        if(this.mod_frequency!=0)
            return target/mod_frequency;

        return target/modulation;
    }



    private void multiHzAdd(double target, double modulation, double multi, int updown, boolean first, double amp, double amp_n)
    {
        if (amp_n!=1)
        {
            if (multi_amp_diff==0) amp=amp*Math.pow(2.0,updown/2);// /Math.sqrt(2);
            if (multi_amp_diff==1) amp=amp;
            if (multi_amp_diff==2) amp=amp*Math.pow(2.0,updown);// /2;
            if (multi_amp_diff==3) amp=amp*Math.pow(amp_n,updown);// /amp_n;
            if (multi_amp_diff==4) amp=amp*Math.pow(amp_n,updown/2);// /Math.sqrt(amp_n);
        }

        android.util.Log.d("SoundHealer", "?target="+target);

        if ((target>tone_hz_min)&&(target<tone_hz_max)) { 
            if ((!first)||(!(updown==1)))
            {
                multi_hz[multi_steps]=target;
                multi_mod_hz[multi_steps]=modulationHzGet(target,modulation);
                multi_amp[multi_steps]=1.0/amp;
                this.amp_sum+=1.0/amp;

                android.util.Log.d("SoundHealer", "multi_hz["+multi_steps+"]="+multi_hz[multi_steps]);
                android.util.Log.d("SoundHealer", "multi_mod_hz["+multi_steps+"]="+multi_mod_hz[multi_steps]);
                android.util.Log.d("SoundHealer", "multi_amp["+multi_steps+"]="+multi_amp[multi_steps]);

                multi_steps++;
            }
            
            if (multi==0) return;
            if (multi==1) return;
        }


        
        if ((updown==1)&&(target>tone_hz_max)) return;
        if ((updown==-1)&&(target<tone_hz_min)) return;
        
            
        if (multi==2) multiHzAdd(target*Math.pow(2.0,updown), modulation, multi,updown,false,amp,2);
        if (multi==3) multiHzAdd(target*Math.pow(3.0,updown), modulation, multi,updown,false,amp,3);
        if (multi==5) multiHzAdd(target*Math.pow(5.0,updown), modulation, multi,updown,false,amp,5);

        if (multi==23) {multiHzAdd(target*Math.pow(2.0,updown), modulation, multi,updown,false,amp,2);multiHzAdd(target*Math.pow(3.0,updown), modulation, multi,updown,false,amp,3);}
        if (multi==25) {multiHzAdd(target*Math.pow(2.0,updown), modulation, multi,updown,false,amp,2);multiHzAdd(target*Math.pow(5.0,updown), modulation, multi,updown,false,amp,5);}

        if (multi==35) {multiHzAdd(target*Math.pow(3.0,updown), modulation, multi,updown,false,amp,3);multiHzAdd(target*Math.pow(5.0,updown), modulation, multi,updown,false,amp,5);}

        if (multi==235) {multiHzAdd(target*Math.pow(2.0,updown), modulation, multi,updown,false,amp,2);multiHzAdd(target*Math.pow(3.0,updown), modulation, multi,updown,false,amp,3);multiHzAdd(target*Math.pow(5.0,updown), modulation, multi,updown,false,amp,5);}
    
        if (multi==123) multiHzAdd(target*Math.pow(1.58496250072,updown), modulation, multi,updown,false,amp,1.58496250072);
        if (multi==74) multiHzAdd(target*Math.pow(7.0/4.0,updown), modulation, multi,updown,false,amp,(7.0/4.0));
    
    }

    private void multiHz(double target, double modulation, double multi)
    {
        this.multi_steps=0;
        this.amp_sum=0;
        this.multi_hz = new double[1000];
        this.multi_mod_hz = new double[1000];
        this.multi_amp = new double[1000];
        
        multiHzAdd(target, modulation, multi,1,true,1.0,1.0);
        multiHzAdd(target, modulation, multi,-1,true,1.0,1.0);
        android.util.Log.d("SoundHealer", "amp_sum="+amp_sum);
    }

    private void bilHz(double target, double modulation, double multi)
    {
        this.multi_steps=2;
        this.amp_sum=2;
        this.multi_hz = new double[5];
        this.multi_mod_hz = new double[5];
        this.multi_amp = new double[5];

        this.multi_steps=2;
        this.amp_sum=2;

        this.multi_hz[0]=target;
        this.multi_hz[1]=target*1.732050807568877; // sqrt(3)
        
        this.multi_amp[0]=1;
        this.multi_amp[1]=1;

        this.multi_mod_hz[0]=modulationHzGet(this.multi_hz[0],modulation);
        this.multi_mod_hz[1]=modulationHzGet(this.multi_hz[1],modulation);

        if(multi==-2)
        {
            this.multi_steps=3;
            this.amp_sum=3;
            this.multi_hz[1]=target*1.451388888888889; // sqrt(2)
            this.multi_hz[2]=target*2.097222222222222; // sqrt(2)
            this.multi_amp[2]=1;
            this.multi_mod_hz[2]=modulationHzGet(this.multi_hz[2],modulation);

        }

        if(multi==-5)
        {
            this.multi_steps=3;
            this.amp_sum=3;
            this.multi_hz[0]=116; // sqrt(2)
            this.multi_hz[1]=233; // sqrt(2)
            this.multi_hz[2]=349; // sqrt(2)
            this.multi_amp[0]=1;
            this.multi_amp[1]=1;
            this.multi_amp[2]=1;
            this.multi_mod_hz[0]=modulationHzGet(this.multi_hz[0],modulation);
            this.multi_mod_hz[1]=modulationHzGet(this.multi_hz[1],modulation);
            this.multi_mod_hz[2]=modulationHzGet(this.multi_hz[2],modulation);

        }

        if(multi==-723)
        {
            this.multi_steps=3;
            this.amp_sum=3;
            this.multi_hz[0]=target; 
            this.multi_hz[1]=this.multi_hz[0]*2;
            this.multi_hz[2]=this.multi_hz[0]*3;
            this.multi_amp[0]=1;
            this.multi_amp[1]=1;
            this.multi_amp[2]=1;
            this.multi_mod_hz[0]=modulationHzGet(this.multi_hz[0],modulation);
            this.multi_mod_hz[1]=modulationHzGet(this.multi_hz[1],modulation);
            this.multi_mod_hz[2]=modulationHzGet(this.multi_hz[2],modulation);

        }

        if(multi==-72)
        {
            this.multi_steps=2;
            this.amp_sum=2;
            this.multi_hz[0]=target; 
            this.multi_hz[1]=this.multi_hz[0]*2; 
            this.multi_amp[0]=1;
            this.multi_amp[1]=1;
            this.multi_mod_hz[0]=modulationHzGet(this.multi_hz[0],modulation);
            this.multi_mod_hz[1]=modulationHzGet(this.multi_hz[1],modulation);
        }

        if(multi==-73)
        {
            this.multi_steps=2;
            this.amp_sum=2;
            this.multi_hz[0]=target;
            this.multi_hz[1]=this.multi_hz[0]*3;
            this.multi_amp[0]=1;
            this.multi_amp[1]=1;
            this.multi_mod_hz[0]=modulationHzGet(this.multi_hz[0],modulation);
            this.multi_mod_hz[1]=modulationHzGet(this.multi_hz[1],modulation);
        }

        if(multi==-7123)
        {
            this.multi_steps=2;
            this.amp_sum=2;
            this.multi_hz[0]=target; 
            this.multi_hz[1]=this.multi_hz[0]*1.58496250072; 
            this.multi_amp[0]=1;
            this.multi_amp[1]=1;
            this.multi_mod_hz[0]=modulationHzGet(this.multi_hz[0],modulation);
            this.multi_mod_hz[1]=modulationHzGet(this.multi_hz[1],modulation);
        }

        if(multi==-774)
        {
            this.multi_steps=2;
            this.amp_sum=2;
            this.multi_hz[0]=target;
            this.multi_hz[1]=this.multi_hz[0]*(7.0/4.0);
            this.multi_amp[0]=1;
            this.multi_amp[1]=1;
            this.multi_mod_hz[0]=modulationHzGet(this.multi_hz[0],modulation);
            this.multi_mod_hz[1]=modulationHzGet(this.multi_hz[1],modulation);
        }

        if(multi==-712)
        {
            this.multi_steps=2;
            this.amp_sum=2;
            this.multi_hz[0]=target;
            this.multi_hz[1]=this.multi_hz[0]/2;
            this.multi_amp[0]=1;
            this.multi_amp[1]=1;
            this.multi_mod_hz[0]=modulationHzGet(this.multi_hz[0],modulation);
            this.multi_mod_hz[1]=modulationHzGet(this.multi_hz[1],modulation);
        }

        if(multi==-713)
        {
            this.multi_steps=2;
            this.amp_sum=2;
            this.multi_hz[0]=target;
            this.multi_hz[1]=this.multi_hz[0]/3;
            this.multi_amp[0]=1;
            this.multi_amp[1]=1;
            this.multi_mod_hz[0]=modulationHzGet(this.multi_hz[0],modulation);
            this.multi_mod_hz[1]=modulationHzGet(this.multi_hz[1],modulation);
        }

        if(multi==-7135)
        {
            this.multi_steps=3;
            this.amp_sum=3;
            this.multi_hz[0]=target;
            this.multi_hz[1]=this.multi_hz[0]/3;
            this.multi_hz[2]=this.multi_hz[0]/5;
            this.multi_amp[0]=1;
            this.multi_amp[1]=1;
            this.multi_amp[2]=2;
            this.multi_mod_hz[0]=modulationHzGet(this.multi_hz[0],modulation);
            this.multi_mod_hz[1]=modulationHzGet(this.multi_hz[1],modulation);
            this.multi_mod_hz[2]=modulationHzGet(this.multi_hz[2],modulation);
        }

        if(multi==-723)
        {
            this.multi_steps=3;
            this.amp_sum=3;
            this.multi_hz[0]=target; // sqrt(2)
            this.multi_hz[1]=target*2; // sqrt(2)
            this.multi_hz[2]=target*3; // sqrt(2)
            this.multi_amp[0]=1;
            this.multi_amp[1]=1;
            this.multi_amp[2]=1;
            this.multi_mod_hz[0]=modulationHzGet(this.multi_hz[0],modulation);
            this.multi_mod_hz[1]=modulationHzGet(this.multi_hz[1],modulation);
            this.multi_mod_hz[2]=modulationHzGet(this.multi_hz[2],modulation);
        }

        //multiHzAdd(target, modulation, multi,1,true,1.0,1.0);
        //multiHzAdd(target, modulation, multi,-1,true,1.0,1.0);
        //android.util.Log.d("SoundHealer", "amp_sum="+amp_sum);
    }


    private void setAngle(double angle)
    {
            this.angle=angle;
            angle2=0;
            if (angle==60) {
                angle2=(Math.PI*2/6);
            }            
            if (angle==90) {
                angle2=(Math.PI*2/4);
            }
            if (angle==120) {
                angle2=(Math.PI*2/3);
            }
            if (angle==180) {
                angle2=(Math.PI*2/2);
            }
            if (angle==137) {
                angle2=2.39996322972865332; // TODO : 2*137.5/360 //Math.PI*(3-sqrt(5)
            }
            
    }


    public double getFrequency() {
        return this.target;
    }

    public void setParams(String program, double target, double enviroment, double modulation, double multi, double angle, double audio) {
        android.util.Log.d("SoundHealer", "program="+program);
        android.util.Log.d("SoundHealer", "target="+target);
        android.util.Log.d("SoundHealer", "enviroment="+enviroment);
        android.util.Log.d("SoundHealer", "modulation="+modulation);
        android.util.Log.d("SoundHealer", "multi="+multi);
        android.util.Log.d("SoundHealer", "angle="+angle);
        android.util.Log.d("SoundHealer", "audio="+audio);

        if (program!="") {
            try {
                JSONObject program_j = new JSONObject(program);
                //JSONArray target_a = program_j.getJSONArray("target");

                String target_s = program_j.getString("target");
                
                android.util.Log.d("SoundHealer", "{target:["+target_s+"]}");

                JSONObject target_j = new JSONObject("{target:["+target_s+"]}");
                JSONArray target_a = target_j.getJSONArray("target");
                targets_count=0;
                targets = new double[target_a.length()];

                for(int i=0;i < target_a.length();i++) {
                    if(target_a.getDouble(i)<70) continue;
                    if(target_a.getDouble(i)>20000) continue;

                    targets[targets_count] = target_a.getDouble(i);
                    targets_count++;
                }

                autonext=program_j.getInt("autonext");
                //android.util.Log.d("SoundHealer", "target_d="+target_d);
                android.util.Log.d("SoundHealer", "targets_count="+targets_count);
                android.util.Log.d("SoundHealer", "autonext="+autonext);
            } catch(Exception e)  {
                android.util.Log.d("SoundHealer/e", e.getMessage());
                e.printStackTrace();
            }
        } else {
            targets_count=0;
        }

        this.target=target;
        this.audio=(int)audio;
        this.multi=multi;
        
        this.modulation=modulation;

        
        if ((modulation>10000)&&(modulation<10099)) {
            this.meandr=modulation-10000;
            this.modulation=10000;

            android.util.Log.d("SoundHealer", "this.modulation="+this.modulation);
            android.util.Log.d("SoundHealer", "this.meandr="+this.meandr);
            //TEMPORARY
            //this.modulation=0;
        }

        if ((modulation>20000)&&(modulation<20099)) {
            this.meandr=modulation-20000;
            this.modulation=20000;

            android.util.Log.d("SoundHealer", "this.modulation="+this.modulation);
            android.util.Log.d("SoundHealer", "this.meandr="+this.meandr);
            //TEMPORARY
            //this.modulation=0;
        }
        

        this.mod_frequency=modulation;

        if ((modulation==2)&&(enviroment!=0))
        {
            this.mod_frequency=enviroment/target;
            target=enviroment;
        }

        this.dumped=false;
        

        if (modulation<0) {this.mod_frequency=-modulation; this.dumped=true;}
        
        
        this.multi_amp_diff=0; //sqrt(2)
        if (modulation==10241) {this.mod_frequency=modulation=1024; this.multi_amp_diff=1;}
        if (modulation==10242) {this.mod_frequency=modulation=1024; this.multi_amp_diff=2;}
        if (modulation==10243) {this.mod_frequency=modulation=1024; this.multi_amp_diff=3;}
        if (modulation==10244) {this.mod_frequency=modulation=1024; this.multi_amp_diff=4;}



        setAngle(angle);

        

        if (multi>=0)
        {
            multiHz(target, modulation, multi);
        } else 
        {
            bilHz(target, modulation, multi);
        }



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
        return (int)(y*Integer.MAX_VALUE);
    }

    public float getValuePosFloat(int xp, int sampleRate, int position, int bufferSamplesSize, int channel) {
        //!!! Возможно просто стоит перейти на 32 Bit
        //!!! Важно. Float возможно не самое лучшее решение, т.к. у основной гармоники наибольшая точность, у остальных пострадает. Пока не ясно...
        double y=getValuePosDouble(xp, sampleRate, position, bufferSamplesSize, channel);
        return (float)y;
    }

    public double getValuePosDouble(int xp, int sampleRate, int position, int bufferSamplesSize, int channel) {

        double y,y_step,t1,t2,mod_amplitude;
        int x;

        x=(position*bufferSamplesSize)+xp;

        if (targets_count>0)
        {
            int num=((x/sampleRate)/autonext)%targets_count;
            multi_hz[0]=targets[num];
            multi_amp[0]=1;
            multi_steps=1;
            //android.util.Log.d("SoundHealer", "replaced hz"+multi_hz[0]);
            this.target=targets[num];
            amp_sum=1;
        }

        y=0;

        for(int step=0;step<multi_steps;step++) {
            if (multi_hz[step]==0) continue;
            t1=(multi_mod_hz[step]*x/sampleRate)*Math.PI*2;
            t2=(multi_hz[step]*x/sampleRate)*Math.PI*2;



            if (/*(this.multi==-33)&&*/(channel==2)&&(angle==1)) 
            {
                t2=((multi_hz[step]+3)*x/sampleRate)*Math.PI*2;
            }
            if (/*(this.multi==-33)&&*/(channel==2)&&(angle==2)) 
            {
                t1=((multi_mod_hz[step]+3)*x/sampleRate)*Math.PI*2;
            }


            if(channel==2)
            {
                t1=t1+angle2;
                t2=t2+angle2;
            }
            


            mod_amplitude=Math.sin(t1);
            if (this.dumped==true) {
                mod_amplitude=1.0-Math.sin(((t1/4) % (Math.PI/2)));                
            }

            if(this.modulation==10000)
            {
                t2= (multi_hz[step]*x/sampleRate) %1 ;
                if (t2*100<=this.meandr) y_step=1; else y_step=0;
            }
            else if(this.modulation==20000)
            {
                t2= (multi_hz[step]*x/sampleRate) %1 ;
                if (t2*100<=this.meandr) y_step=1; else y_step=-1;
            }
            else if(this.modulation==0)
            { 
                y_step=Math.sin(t2); //no modulation
            } else {
                y_step=Math.sin(t2)*((mod_amplitude+1)/2); //AM modulation, volume positive
            }


            /*
            if(this.modulation==10000) 
            {
                //y_step=multi_mod_hz[step]*x/sampleRate
                //this.meandr;
            }*/


            y_step=y_step*multi_amp[step];//(Math.pow(tone_pow,(tone_steps-1-step)));

            y=y+y_step;        
        }

        //correct sum
        y=y/amp_sum; //(1.0+0.5+0.25+0.125+0.0625+0.03125+0.015625);
        
        //android.util.Log.d("SoundHealer", "y="+y);

        return y;
    }
}
