package com.namyxc.firebasedemo;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.EditText;

import com.google.firebase.analytics.FirebaseAnalytics;
import com.google.firebase.crash.FirebaseCrash;

public class MainActivity extends AppCompatActivity {


  private FirebaseAnalytics mFirebaseAnalytics;

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    setContentView(R.layout.activity_main);
    mFirebaseAnalytics = FirebaseAnalytics.getInstance(this);
  }

  public void setFood(View v){
    String foodName = ((EditText)findViewById(R.id.foodName)).getText().toString();
    mFirebaseAnalytics.setUserProperty("kedvenc_etel", foodName);
  }

  public void buyFood(View v){
    String foodName = ((EditText)findViewById(R.id.foodName)).getText().toString();

    Bundle bundle = new Bundle();
    bundle.putString(FirebaseAnalytics.Param.ITEM_NAME, foodName);
    bundle.putString(FirebaseAnalytics.Param.VIRTUAL_CURRENCY_NAME, "peták");
    bundle.putDouble(FirebaseAnalytics.Param.VALUE, 50);
    mFirebaseAnalytics.logEvent(FirebaseAnalytics.Event.ECOMMERCE_PURCHASE, bundle);
  }
  public void setDrink(View v){
    String drinkName = ((EditText)findViewById(R.id.drinkName)).getText().toString();
    mFirebaseAnalytics.setUserProperty("kedvenc_ital", drinkName);
  }

  public void buyDrink(View v){
    String drinkName = ((EditText)findViewById(R.id.drinkName)).getText().toString();

    Bundle bundle = new Bundle();
    bundle.putString(FirebaseAnalytics.Param.ITEM_NAME, drinkName);
    bundle.putString(FirebaseAnalytics.Param.VIRTUAL_CURRENCY_NAME, "koin");
    bundle.putDouble(FirebaseAnalytics.Param.VALUE, 10);
    mFirebaseAnalytics.logEvent(FirebaseAnalytics.Event.ECOMMERCE_PURCHASE, bundle);
  }

  public void setNonFatalError(View v){
    FirebaseCrash.report(new Exception("Hiba történt, de kezeltük"));
  }

  public void log(View v){
    String foodName = ((EditText)findViewById(R.id.foodName)).getText().toString();
    String drinkName = ((EditText)findViewById(R.id.drinkName)).getText().toString();
    FirebaseCrash.log("Log: " + foodName + " - " + drinkName);
  }
}
